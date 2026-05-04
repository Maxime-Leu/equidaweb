package servlet;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import database.DaoCheval;
import database.DaoRace;
import database.DaoVente;
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
import model.Vente;

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
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String path = request.getPathInfo();
        System.out.println("PathInfo: " + path);

        if ("/list".equals(path)) {
            ArrayList<Vente> lesVentes = DaoVente.getLesVentes(cnx); // Note: Vérifie si c'est Vente ou Cheval ici selon ton besoin
            ArrayList<Cheval> lesChevaux = DaoCheval.getLesChevaux(cnx);
            request.setAttribute("pLesChevaux", lesChevaux);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/list.jsp").forward(request, response);
        }
        else if ("/show".equals(path)) {
            try {
                int idCheval = Integer.parseInt(request.getParameter("idCheval"));
                Cheval leCheval = DaoCheval.getLeCheval(cnx, idCheval);
                ArrayList<ChevalCourse> chevalCourses = DaoCheval.getLesCoursesByCheval(cnx, idCheval);
                
                if (leCheval != null) {
                    request.setAttribute("pLeCheval", leCheval);
                    request.setAttribute("pChevalCourses", chevalCourses);
                    this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/show.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/cheval-servlet/list");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/cheval-servlet/list");
            }
        }
        else if ("/add".equals(path)) {
            ArrayList<Race> lesRaces = DaoRace.getLesRaces(cnx);
            request.setAttribute("pLesRaces", lesRaces);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/add.jsp").forward(request, response);
        }
        // --- NOUVEAU : AFFICHER LE FORMULAIRE DE MODIFICATION ---
        else if ("/edit".equals(path)) {
            try {
                int idCheval = Integer.parseInt(request.getParameter("idCheval"));
                Cheval leCheval = DaoCheval.getLeCheval(cnx, idCheval);
                ArrayList<Race> lesRaces = DaoRace.getLesRaces(cnx);
                
                request.setAttribute("pCheval", leCheval);
                request.setAttribute("pLesRaces", lesRaces);
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/edit.jsp").forward(request, response);
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/cheval-servlet/list");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        if ("/add".equals(path)) {
            try {
                Cheval nouveauCheval = extraireCheval(request);
                if (DaoCheval.ajouterCheval(cnx, nouveauCheval)) {
                    response.sendRedirect(request.getContextPath() + "/cheval-servlet/show?idCheval=" + nouveauCheval.getId());
                } else {
                    throw new Exception("Erreur lors de l'enregistrement du cheval");
                }
            } catch (Exception e) {
                request.setAttribute("message", "Erreur : " + e.getMessage());
                request.setAttribute("pLesRaces", DaoRace.getLesRaces(cnx));
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/add.jsp").forward(request, response);
            }
        }
        // --- NOUVEAU : ENREGISTRER LA MODIFICATION ---
        else if ("/edit".equals(path)) {
            try {
                int id = Integer.parseInt(request.getParameter("id")); // L'id caché dans le formulaire
                Cheval chevalModifie = extraireCheval(request);
                chevalModifie.setId(id);

                DaoCheval.updateCheval(cnx, chevalModifie);
                response.sendRedirect(request.getContextPath() + "/cheval-servlet/show?idCheval=" + id);
            } catch (Exception e) {
                request.setAttribute("message", "Erreur : " + e.getMessage());
                request.setAttribute("pLesRaces", DaoRace.getLesRaces(cnx));
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/edit.jsp").forward(request, response);
            }
        }
    }

    // Petite méthode utilitaire pour éviter de répéter le code de récupération des champs
    private Cheval extraireCheval(HttpServletRequest request) throws Exception {
        String nom = request.getParameter("nom");
        String dateNaissanceStr = request.getParameter("dateNaissance");
        int raceId = Integer.parseInt(request.getParameter("race"));
        String sexe = request.getParameter("sexe");
        String sire = request.getParameter("sire");

        Cheval c = new Cheval();
        c.setNom(nom);
        c.setSexe(sexe);
        c.setSire(sire);

        if (dateNaissanceStr != null && !dateNaissanceStr.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            c.setDateNaissance(sdf.parse(dateNaissanceStr));
        }

        Race race = DaoRace.getRaceById(cnx, raceId);
        if (race != null) {
            c.setRace(race);
        } else {
            throw new Exception("La race sélectionnée n'existe pas");
        }
        return c;
    }

    @Override
    public void destroy() {
    }
}