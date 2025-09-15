package test;

import java.time.LocalDate;
import model.CategVente;
import model.Vente;


public class TestCategVente {
    public static void main(String[] args) {
        
        // 1. Instanciation d’une catégorie
        CategVente c = new CategVente(1, "chevalquicourtvite");

        // 2. Instanciation de deux ventes
        Vente v1 = new Vente(101, "cheval", "2001-09-09");
        Vente v2 = new Vente(102, "cheval3", "1945-08-06");

        // 3. Ajout des ventes dans la catégorie
        c.addUneVente(v1);
        c.addUneVente(v2);

        // 4. Affichage des informations de la catégorie
        System.out.println("Catégorie : " + c.getLibelle());
        System.out.println("Liste des ventes : ");

        // 5. Parcours et affichage des ventes
        for (Vente v : c.getLesVentes()) {
            System.out.println(" -> ID : " + v.getId() + " | Nom : " + v.getNom() + " | Date du debut de la vente : "+ v.getDebutVente());
        }
    }
}


