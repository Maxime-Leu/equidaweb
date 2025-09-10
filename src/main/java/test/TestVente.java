package test;

import model.Vente;
import model.CategVente;
import model.Lieu;
import model.Lot;

public class TestVente {

    public static void main (String args[]){

        // création d'une instance de Vente nommé v & v1
        Vente v = new Vente();
        v.setId(2);
        v.setNom("ventedelapuff");
        
        Vente v1 = new Vente();
        v1.setId(3);
        v1.setNom("Porte de clignancourt");
        
        // création d'une instance de CategVente nommé c
        CategVente c = new CategVente();
        c.setId(1);
        c.setLibelle("9k");
        
        // création d'une instance de Lieu nommé l
        Lieu l = new Lieu();
        l.setId(1);
        l.setVille("Porte de Clignancourt");
        l.setNbBoxes(100);

        // relations ManyToOne
        v.setCategVente(c);
        v1.setLieu(l);

        // création de lots
        Lot lot1 = new Lot(101, 10000);
        Lot lot2 = new Lot(102, 15000);

        // ajout des lots dans la vente v
        v.addUnLot(lot1);
        v.addUnLot(lot2);

        // affichage des informations
        System.out.println("Vente : " + v.getId() + " " + v.getNom() 
                + " | Catégorie : " + v.getCategVente().getId() + " " + v.getCategVente().getLibelle() 
                + " | Lieu : " + v1.getLieu().getVille());

        System.out.println("Lots de la vente " + v.getNom() + " : ");
        for (Lot lot : v.getLesLots()) {
            System.out.println(" -> ID Lot : " + lot.getId() + " | Prix de depart : " + lot.getPrixDepart());
        }
    }
}
