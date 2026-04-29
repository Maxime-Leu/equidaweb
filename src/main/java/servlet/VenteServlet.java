package servlet;

import database.DaoLot;
import database.DaoVente;
import database.DaoLieu;
import database.DaoCategVente;
import java.io.*;
import java.sql.Connection;
import java.util.ArrayList;

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

        // 1. LISTER LES VENTES
        if ("/list".equals(path)) {
            ArrayList<Vente> lesVentes = DaoVente.getLesVentes(cnx);
            request.setAttribute("pLesVentes", lesVentes);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/list.jsp").forward(request, response);
        }

        // 2. VOIR LES DÉTAILS
        else if ("/show".equals(path)) {
            try {
                int idVente = Integer.parseInt(request.getParameter("idVente"));
                Vente laVente = DaoVente.getLaVente(cnx, idVente);
                ArrayList<Cheval> chevaux = DaoLot.getChevauxEnVente(cnx, idVente);
                
                request.setAttribute("pLaVente", laVente);
                request.setAttribute("pLesChevauxEnVente", chevaux);
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/show.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
            }
        }

        // 3. AFFICHER FORMULAIRE AJOUT
        else if ("/add".equals(path)) {
            request.setAttribute("pLesLieux", DaoLieu.getLesLieux(cnx));
            request.setAttribute("pLesCategVentes", DaoCategVente.getLesCategVentes(cnx));
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/add.jsp").forward(request, response);
        }

        // 4. AFFICHER FORMULAIRE MODIF
        else if ("/edit".equals(path)) {
            System.out.println("=== ENTREE DANS /edit ===");
            try {
                String idParam = request.getParameter("idVente");
                System.out.println("=== idVente recu = " + idParam);
                
                int idVente = Integer.parseInt(idParam); 
                Vente laVente = DaoVente.getLaVente(cnx, idVente);
                System.out.println("=== laVente = " + laVente);
                
                if (laVente != null) {
                    System.out.println("=== laVente != null, on forward vers edit.jsp ===");
                    request.setAttribute("pVente", laVente);
                    request.setAttribute("pLesLieux", DaoLieu.getLesLieux(cnx));
                    request.setAttribute("pLesCategVentes", DaoCategVente.getLesCategVentes(cnx));
                    this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/edit.jsp").forward(request, response);
                } else {
                    System.out.println("=== laVente EST NULL, redirect list ===");
                    response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
                }
            } catch (Exception e) {
                System.out.println("=== EXCEPTION : " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        // TRAITEMENT DE L'AJOUT
        if ("/add".equals(path)) {
            try {
                Vente nouvelleVente = remplirVenteDepuisForm(request);
                if (DaoVente.ajouterVente(cnx, nouvelleVente)) {
                    response.sendRedirect(request.getContextPath() + "/vente-servlet/show?idVente=" + nouvelleVente.getId());
                }
            } catch (Exception e) {
                e.printStackTrace();
                reafficherFormulaire(request, response, "/WEB-INF/views/vente/add.jsp", e.getMessage());
            }
        }

        // TRAITEMENT DE LA MODIF (ENREGISTREMENT)
        else if ("/edit".equals(path)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Vente venteModifiee = remplirVenteDepuisForm(request);
                venteModifiee.setId(id);

                DaoVente.updateVente(cnx, venteModifiee);
                response.sendRedirect(request.getContextPath() + "/vente-servlet/show?idVente=" + id);
            } catch (Exception e) {
                e.printStackTrace();
                reafficherFormulaire(request, response, "/WEB-INF/views/vente/edit.jsp", e.getMessage());
            }
        }
    }

    private Vente remplirVenteDepuisForm(HttpServletRequest request) throws Exception {
        Vente v = new Vente();
        v.setNom(request.getParameter("nom"));
        String dateStr = request.getParameter("dateDebutVente");
        if (dateStr != null && !dateStr.isEmpty()) {
            v.setDateDebutVente(new SimpleDateFormat("yyyy-MM-dd").parse(dateStr));
        }
        Lieu l = new Lieu();
        l.setId(Integer.parseInt(request.getParameter("idLieu")));
        v.setLieu(l);
        CategVente c = new CategVente();
        c.setId(Integer.parseInt(request.getParameter("idCateg")));
        v.setCategVente(c);
        return v;
    }

    private void reafficherFormulaire(HttpServletRequest request, HttpServletResponse response, String jspPath, String errorMsg) throws ServletException, IOException {
        request.setAttribute("message", "Erreur : " + errorMsg);
        request.setAttribute("pLesLieux", DaoLieu.getLesLieux(cnx));
        request.setAttribute("pLesCategVentes", DaoCategVente.getLesCategVentes(cnx));
        this.getServletContext().getRequestDispatcher(jspPath).forward(request, response);
    }
}