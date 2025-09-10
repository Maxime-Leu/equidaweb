package test;

import model.Vente;
import model.Lot;


public class TestLot {

    public static void main (String args[]){

        // création d'une instance de Vente nommé v & v1
        Lot l = new Lot();
        l.setId(2);
        l.setPrixDepart(35000);
        
        
        // création d'une instance de CategVente nommé c
        Vente v= new Vente ();
        v.setId(1);
        v.setNom("bassem");

        //relations ManyToOne
        l.setVente(v);
        

        // Affichage des informations dans la console
        
        System.out.println("Lot numero : " + l.getId() + ". Prix de depart: " + l.getPrixDepart() + " ;"
                + l.getVente().getId() + " Nom: " + l.getVente().getNom());
        
        
    }
}
