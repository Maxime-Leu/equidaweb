package servlet;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import database.DaoCheval;
import database.DaoRace;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import model.Cheval;
import model.ChevalCourse;
import model.Race;

@WebServlet(name = "chevalServlet", value = "/cheval-servlet/*")
public class ChevalServlet extends HttpServlet {

    Connection cnx;
    
    @Override
    public void init() {
        ServletContext servletContext = getServletContext();
        cnx = (Connection)servletContext.getAttribute("connection");
        try {
            System.out.println("INIT SERVLET=" + cnx.getSchema());
        } catch (SQLException ex) {
            Logger.getLogger(ChevalServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String path = request.getPathInfo();
        System.out.println("PathInfo: " + path);

        if ("/list".equals(path)) {
            ArrayList<Cheval> lesChevaux = DaoCheval.getLesChevaux(cnx);
            request.setAttribute("pLesChevaux", lesChevaux);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/list.jsp").forward(request, response);
        }
        if ("/show".equals(path)) {
            try {
                int idCheval = Integer.parseInt(request.getParameter("idCheval"));
                Cheval leCheval = DaoCheval.getLeCheval(cnx, idCheval);
                ArrayList<ChevalCourse> chevalCourses = DaoCheval.getLesCoursesByCheval(cnx, idCheval);
                System.out.println("COURSE"+chevalCourses.size());
                if (leCheval != null) {
                    request.setAttribute("pLeCheval", leCheval);
                    request.setAttribute("pChevalCourses", chevalCourses);
                    this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/show.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/cheval-servlet/list");
                }
            } catch (NumberFormatException e) {
                System.out.println("Erreur : l'id du cheval n'est pas un nombre valide");
                response.sendRedirect(request.getContextPath() + "/cheval-servlet/list");
            }

        }

        if ("/add".equals(path)) {
            ArrayList<Race> lesRaces = DaoRace.getLesRaces(cnx);
            request.setAttribute("pLesRaces", lesRaces);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/add.jsp").forward(request, response);
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        if ("/add".equals(path)) {
    try {
       
        String nom = request.getParameter("nom");
        String dateNaissanceStr = request.getParameter("dateNaissance");
        int raceId = Integer.parseInt(request.getParameter("race"));
        String sexe = request.getParameter("sexe");
        String sire = request.getParameter("sire");
        

       
        Cheval nouveauCheval = new Cheval();
        nouveauCheval.setNom(nom);
        nouveauCheval.setSexe(sexe);
        nouveauCheval.setSire(sire);

      
        if (dateNaissanceStr != null && !dateNaissanceStr.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date dateNaissance = (Date) sdf.parse(dateNaissanceStr);
                nouveauCheval.setDateNaissance(dateNaissance);
            } catch (ParseException e) {
                throw new Exception("Format de date invalide (attendu : yyyy-MM-dd)");
            }
        }

       
        Race race = DaoRace.getRaceById(cnx, raceId);
        if (race != null) {
            nouveauCheval.setRace(race);
        } else {
            throw new Exception("La race sélectionnée n'existe pas");
        }

        
        if (DaoCheval.ajouterCheval(cnx, nouveauCheval)) {
            
            response.sendRedirect(request.getContextPath() + "/cheval-servlet/show?idCheval=" + nouveauCheval.getId());
        } else {
            throw new Exception("Erreur lors de l'enregistrement du cheval");
        }

    } catch (NumberFormatException e) {
        request.setAttribute("message", "Erreur : la race sélectionnée n'est pas valide");
        request.setAttribute("pLesRaces", DaoRace.getLesRaces(cnx));
        this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/add.jsp").forward(request, response);
    } catch (Exception e) {
        request.setAttribute("message", "Erreur : " + e.getMessage());
        request.setAttribute("pLesRaces", DaoRace.getLesRaces(cnx));
        this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/add.jsp").forward(request, response);
    }
}
    }

    public void destroy() {
    }
}
