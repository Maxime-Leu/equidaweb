package database;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener; 

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebListener
public class ConnexionServlet implements ServletContextListener {

    Connection cnx = null;

    public void contextInitialized(ServletContextEvent event)
    {
        //Initialisation et lecture du contexte
        ServletContext servletContext = event.getServletContext();
        System.out.println("INITCONNEXION " + servletContext.getContextPath());
        try
        {
            //chargement du driver
            Class.forName("org.mariadb.jdbc.Driver");
            System.out.println("Pilote Mariadb JDBC chargé");

            try
            {
                //obtention de la connexion (vérifie bien que le port est 3307 au lycée aussi)
                cnx = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/equida","root","");
                //sauvegarder la connexion dans le context
                servletContext.setAttribute("connection", cnx);
                System.out.println("Connexion opérationnelle sur jdbc:mariadb://127.0.0.1:3306/equida");
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                System.out.println("Erreur lors de l’établissement de la connexion");
            }
        }
        catch (ClassNotFoundException e)
        {
            e.printStackTrace();
            System.out.println("Erreur lors du chargemement du pilote");
        }
    }

    public void contextDestroyed(ServletContextEvent event)
    {
        System.out.println("----------- Contexte détruit -----------");
        try
        {
            if (cnx != null) {
                cnx.close();
                System.out.println("Connexion fermée");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}