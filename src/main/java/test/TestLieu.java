package test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Lieu;
import model.Vente;

public class TestLieu {
    public static void main(String[] args) {
        try {
            
            Lieu l = new Lieu(1, "Grigny la grande borne", 3);

            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

           
            Date date1 = sdf.parse("2001-09-09");
            Date date2 = sdf.parse("1945-08-06");

            Vente v1 = new Vente(101, "cheval", date1);
            Vente v2 = new Vente(102, "cheval3", date2);

           
            l.addUneVente(v1);
            l.addUneVente(v2);

          
            System.out.println("Ville : " + l.getVille());
            System.out.println("Liste des ventes :");

           
            for (Vente v : l.getLesVentes()) {
                System.out.println(" -> ID : " + v.getId()
                        + " | Nom : " + v.getNom()
                        + " | Date de début de la vente : " + sdf.format(v.getDateDebutVente()));
            }

        } catch (ParseException e) {
            e.printStackTrace();
            System.out.println("Erreur lors du parsing de la date.");
        }
    }
}
