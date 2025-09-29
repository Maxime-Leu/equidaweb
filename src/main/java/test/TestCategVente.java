package test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.CategVente;
import model.Vente;

public class TestCategVente {
    public static void main(String[] args) {
        try {
           
            CategVente c = new CategVente(1, "chevalquicourtvite");


            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

          
            Date date1 = sdf.parse("2001-09-09");
            Date date2 = sdf.parse("1945-08-06");

            Vente v1 = new Vente(101, "cheval", date1);
            Vente v2 = new Vente(102, "cheval3", date2);

           
            c.addUneVente(v1);
            c.addUneVente(v2);

          
            System.out.println("Catégorie : " + c.getLibelle());
            System.out.println("Liste des ventes :");

           
            for (Vente v : c.getLesVentes()) {
                System.out.println(" -> ID : " + v.getId()
                        + " | Nom : " + v.getNom()
                        + " | Date du début de la vente : " + sdf.format(v.getDateDebutVente()));
            }

        } catch (ParseException e) {
            e.printStackTrace();
            System.out.println("Erreur lors du parsing de la date.");
        }
    }
}
