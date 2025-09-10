package test;

import model.Vente;
import model.Lot;
import model.Enchere;

public class TestLot {

    public static void main (String args[]){

        // création d'une instance de Lot
        Lot l = new Lot();
        l.setId(2);
        l.setPrixDepart(35000);

        // création d'une instance de Vente
        Vente v = new Vente();
        v.setId(1);
        v.setNom("bassem");

        // relation ManyToOne
        l.setVente(v);

        // création d'enchères
        Enchere e1 = new Enchere();
        e1.setId(101);
        e1.setMontant(36000);

        Enchere e2 = new Enchere();
        e2.setId(102);
        e2.setMontant(37000);

        // ajout des enchères dans le lot
        l.addUneEnchere(e1);
        l.addUneEnchere(e2);

        // affichage des informations du lot
        System.out.println("Lot numero : " + l.getId() 
                + " ; Prix de depart: " + l.getPrixDepart()
                + " ; Vente associée : " + l.getVente().getId() + " - " + l.getVente().getNom());

        // affichage des enchères associées au lot
        System.out.println("Enchères pour ce lot :");
        for (Enchere e : l.getLesEncheres()) {
            System.out.println(" -> Enchère " + e.getId() + " | Montant : " + e.getMontant());
        }
    }
}
