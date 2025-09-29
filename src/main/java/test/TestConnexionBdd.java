package test;

import java.sql.Connection;
import database.DaoVente;
import database.Connexionbdd;
import database.DaoCheval;



public class TestConnexionBdd {

    public static void main (String args[]) {

        Connection cnx = Connexionbdd.ouvrirConnexion();
        System.out.println ("nombre de chevaux = " + DaoCheval.getLesChevaux(cnx).size());
        System.out.println ("Le cheval numero 1 = " + DaoCheval.getLeCheval(cnx, 1).getNom());

        System.out.println ("nombre de ventes = " + DaoVente.getLesVentes(cnx).size());
        System.out.println ("La vente numero 3 = " + DaoVente.getLaVente(cnx, 3).getNom());
    
        
    
    }

}
