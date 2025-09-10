package test;

import model.Enchere;
import model.Lot;


public class TestEnchere {

    public static void main (String args[]){

        // création d'une instance de Vente nommé v & v1
        Enchere e = new Enchere();
        e.setId(2);
        e.setMontant(150000);
        
        
        // création d'une instance de CategVente nommé c
        Lot l = new Lot();
        l.setId(1);
        l.setPrixDepart(5);

        //relations ManyToOne
        e.setLot(l);
        

        // Affichage des informations dans la console
        
        System.out.println("Enchere numero : " + e.getId() + ". Le montant est de " + e.getMontant() + " "
                + e.getLot().getId() + " Prix de depart: " + e.getLot().getPrixDepart());
        
        
    }
}
