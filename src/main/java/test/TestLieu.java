package test;

import java.time.LocalDate;
import model.Lieu;
import model.Vente;


public class TestLieu {
    public static void main(String[] args) {
        
        // 1. Instanciation d’une catégorie
        Lieu l = new Lieu(1, "Grigny la grande borne", 3);

        // 2. Instanciation de deux ventes
        Vente v1 = new Vente(101, "cheval", "2001-09-09");
        Vente v2 = new Vente(102, "cheval3", "1945-08-06");

        // 3. Ajout des ventes dans la catégorie
        l.addUneVente(v1);
        l.addUneVente(v2);

        // 4. Affichage des informations de la catégorie
        System.out.println("Ville : " + l.getVille());
        System.out.println("Liste des ventes : ");

        // 5. Parcours et affichage des ventes
        for (Vente v : l.getLesVentes()) {
            System.out.println(" -> ID : " + v.getId() + " | Nom : " + v.getNom() + " | Nom : " + v.getDebutVente()); 
            
    }

    }
}



