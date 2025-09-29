package test;

import model.Enchere;
import model.Lot;


public class TestEnchere {

    public static void main (String args[]){

       
        Enchere e = new Enchere();
        e.setId(2);
        e.setMontant(150000);
        
        
        
        Lot l = new Lot();
        l.setId(1);
        l.setPrixDepart(5);

      
        e.setLot(l);
        

        
        
        System.out.println("Enchere numero : " + e.getId() + ". Le montant est de " + e.getMontant() + " "
                + e.getLot().getId() + " Prix de depart: " + e.getLot().getPrixDepart());
        
        
    }
}
