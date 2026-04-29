package servlet;

import database.DaoLot;
import database.DaoVente;
import database.DaoLieu;
import database.DaoCategVente; // Import à ajouter
import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.text.SimpleDateFormat;
import model.Cheval;
import model.Vente;
import model.Lieu;
import model.CategVente;

@WebServlet(name = "venteServlet", value = "/vente-servlet/*")
public class VenteServlet extends HttpServlet {

    Connection cnx;
    
    @Override
    public void init() {
        ServletContext servletContext = getServletContext();
        cnx = (Connection)servletContext.getAttribute("connection");
    }
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String path = request.getPathInfo();

        if ("/list".equals(path)) {
            ArrayList<Vente> lesVentes = DaoVente.getLesVentes(cnx);
            request.setAttribute("pLesVentes", lesVentes);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/list.jsp").forward(request, response);
        }

        if ("/show".equals(path)) {
            try {
                int idVente = Integer.parseInt(request.getParameter("idVente"));
                Vente laVente = DaoVente.getLaVente(cnx, idVente);
                ArrayList<Cheval> chevaux = DaoLot.getChevauxEnVente(cnx, idVente);
                
                if (laVente != null) {
                    request.setAttribute("pLaVente", laVente);
                    request.setAttribute("pLesChevauxEnVente", chevaux);
                    this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/show.jsp").forward(request, response);
                } else {
                    // Correction : redirection vers /list et non /lister
                    response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
            }
        }

        if ("/add".equals(path)) {
            // Modification : On récupère les Lieux et Catégories au lieu des Races
            ArrayList<Lieu> lesLieux = DaoLieu.getLesLieux(cnx);
            ArrayList<CategVente> lesCategVentes = DaoCategVente.getLesCategVentes(cnx);
            
            request.setAttribute("pLesLieux", lesLieux);
            request.setAttribute("pLesCategVentes", lesCategVentes);
            
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
                int idLieu = Integer.parseInt(request.getParameter("idLieu"));
                int idCateg = Integer.parseInt(request.getParameter("idCateg"));

                Vente nouvelleVente = new Vente();
                nouvelleVente.setNom(nom);

                // Gestion de la date (Correction du cast java.util.Date)
                if (dateDebutVenteStr != null && !dateDebutVenteStr.isEmpty()) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date dateDebut = sdf.parse(dateDebutVenteStr);
                    nouvelleVente.setDateDebutVente(dateDebut);
                }

                // Association du Lieu et de la Catégorie
                Lieu unLieu = new Lieu();
                unLieu.setId(idLieu);
                nouvelleVente.setLieu(unLieu);

                CategVente uneCateg = new CategVente();
                uneCateg.setId(idCateg);
                nouvelleVente.setCategVente(uneCateg);

                if (DaoVente.ajouterVente(cnx, nouvelleVente)) {
                    // Correction : on utilise idVente pour correspondre au doGet
                    response.sendRedirect(request.getContextPath() + "/vente-servlet/show?idVente=" + nouvelleVente.getId());
                } else {
                    throw new Exception("Erreur lors de l'enregistrement de la vente");
                }

            } catch (Exception e) {
                request.setAttribute("message", "Erreur : " + e.getMessage());
                // On doit re-charger les listes pour réafficher le formulaire en cas d'erreur
                request.setAttribute("pLesLieux", DaoLieu.getLesLieux(cnx));
                request.setAttribute("pLesCategVentes", DaoCategVente.getLesCategVentes(cnx));
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/add.jsp").forward(request, response);
            }
        }
    }
}