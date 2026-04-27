package servlet;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import database.DaoEnchere;
import database.DaoLot;
import model.Lot;

@WebServlet(name = "enchereServlet", value = "/enchere-servlet/*")
public class EnchereServlet extends HttpServlet {

    Connection cnx;

    @Override
    public void init() {
        ServletContext servletContext = getServletContext();
        cnx = (Connection) servletContext.getAttribute("connection");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        System.out.println("PathInfo Enchere: " + path);

        if ("/ajouter".equals(path)) {
            try {
                // 1. Récupération des paramètres (On utilise lot_id comme dans ton DAO)
                int lot_id = Integer.parseInt(request.getParameter("lot_id"));
                int montantPropose = Integer.parseInt(request.getParameter("montant"));
                
                // Pour l'instant on met l'ID 6 en dur (Acheteur de test)
                int idAcheteur = 6; 

                // 2. Récupération des infos du lot pour vérification
                Lot leLot = DaoLot.getLeLot(cnx, lot_id);
                int montantMaxActuel = DaoEnchere.getMontantMaxLot(cnx, lot_id);

                if (leLot == null) {
                    throw new Exception("Le lot n'existe pas.");
                }

                // 3. Règle métier : la mise doit être > au prix de départ ET > à l'enchère actuelle
                if (montantPropose > leLot.getPrixDepart() && montantPropose > montantMaxActuel) {
                    
                    // 4. Enregistrement (Appel de ton DAO avec lot_id)
                    DaoEnchere.addEnchere(cnx, montantPropose, lot_id, idAcheteur);
                    
                    // 5. Redirection vers la page du cheval
                    // On utilise leLot.getLeCheval().getId() suite à la modif du modèle
                    response.sendRedirect(request.getContextPath() + "/cheval-servlet/show?idCheval=" + leLot.getLeCheval().getId() + "&success=1");
                } else {
                    // Si la mise est trop basse, on renvoie sur la fiche avec un message d'erreur
                    response.sendRedirect(request.getContextPath() + "/cheval-servlet/show?idCheval=" + leLot.getLeCheval().getId() + "&error=1");
                }

            } catch (NumberFormatException e) {
                System.out.println("Erreur de format de nombre : " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
            } catch (Exception e) {
                System.out.println("Erreur Enchere : " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
            }
        }
    }
}