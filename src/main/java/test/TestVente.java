package test;

import model.Vente;
import model.CategVente;
import model.Lieu;
import model.Lot;

public class TestVente {

    public static void main (String args[]){

       
        Vente v = new Vente();
        v.setId(2);
        v.setNom("jsp");
        
        Vente v1 = new Vente();
        v1.setId(3);
        v1.setNom("Porte de clignancourt");
        
      
        CategVente c = new CategVente();
        c.setId(1);
        c.setLibelle("9k");
        
      
        Lieu l = new Lieu();
        l.setId(1);
        l.setVille("Porte de Clignancourt");
        l.setNbBoxes(100);

     
        v.setCategVente(c);
        v1.setLieu(l);

   
        Lot lot1 = new Lot(101, 10000);
        Lot lot2 = new Lot(102, 15000);

       
        v.addUnLot(lot1);
        v.addUnLot(lot2);

       
        System.out.println("Vente : " + v.getId() + " " + v.getNom() 
                + " | Catégorie : " + v.getCategVente().getId() + " " + v.getCategVente().getLibelle() 
                + " | Lieu : " + v1.getLieu().getVille());

        System.out.println("Lots de la vente " + v.getNom() + " : ");
        for (Lot lot : v.getLesLots()) {
            System.out.println(" -> ID Lot : " + lot.getId() + " | Prix de depart : " + lot.getPrixDepart());
        }
    }
}
