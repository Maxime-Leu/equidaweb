package servlet;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import database.DaoVente;

import database.DaoRace;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.sql.Date;
import java.text.SimpleDateFormat;

import model.Race;
import model.Vente;

@WebServlet(name = "venteServlet", value = "/vente-servlet/*")
public class VenteServlet extends HttpServlet {

    Connection cnx;
    
    @Override
    public void init() {
        ServletContext servletContext = getServletContext();
        cnx = (Connection)servletContext.getAttribute("connection");
        try {
            System.out.println("INIT SERVLET=" + cnx.getSchema());
        } catch (SQLException ex) {
            Logger.getLogger(VenteServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String path = request.getPathInfo();
        System.out.println("PathInfo: " + path);

        if ("/list".equals(path)) {
            ArrayList<Vente> lesVentes = DaoVente.getLesVentes(cnx);
            request.setAttribute("pLesVentes", lesVentes);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/list.jsp").forward(request, response);
        }
        if ("/show".equals(path)) {
            try {
                int idVente = Integer.parseInt(request.getParameter("idVente"));
                Vente laVente = DaoVente.getLaVente(cnx, idVente);

                if (laVente != null) {
                    request.setAttribute("pLaVente", laVente);
                    this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/show.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/vente-servlet/lister");
                }
            } catch (NumberFormatException e) {
                System.out.println("Erreur : l'id de la vente n'est pas un nombre valide");
                response.sendRedirect(request.getContextPath() + "/vente-servlet/lister");
            }

        }

        if ("/add".equals(path)) {
            ArrayList<Race> lesRaces = DaoRace.getLesRaces(cnx);
            request.setAttribute("pLesRaces", lesRaces);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/add.jsp").forward(request, response);
        }


    }
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String path = request.getPathInfo();

    if ("/add".equals(path)) {
        try {
           
            String nom = request.getParameter("nom");
            String dateDebutVenteStr = request.getParameter("dateDebutVente");

            
            Vente nouvelleVente = new Vente();
            nouvelleVente.setNom(nom);

            
            if (dateDebutVenteStr != null && !dateDebutVenteStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dateDebut = (Date) sdf.parse(dateDebutVenteStr);
                nouvelleVente.setDateDebutVente(dateDebut);
            }

           
            
            if (DaoVente.ajouterVente(cnx, nouvelleVente)) {
                response.sendRedirect(request.getContextPath() + "/vente-servlet/show?id=" + nouvelleVente.getId());
            } else {
                throw new Exception("Erreur lors de l'enregistrement de la vente");
            }

        } catch (Exception e) {
            request.setAttribute("message", "Erreur : " + e.getMessage());
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/add.jsp").forward(request, response);
        }
    }
}


}
