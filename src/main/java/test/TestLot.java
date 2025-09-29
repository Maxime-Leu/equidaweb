package test;

import model.Vente;
import model.Lot;
import model.Enchere;

public class TestLot {

    public static void main (String args[]){

       
        Lot l = new Lot();
        l.setId(2);
        l.setPrixDepart(35000);

      
        Vente v = new Vente();
        v.setId(1);
        v.setNom("bassem");

      
        l.setVente(v);

      
        Enchere e1 = new Enchere();
        e1.setId(101);
        e1.setMontant(36000);

        Enchere e2 = new Enchere();
        e2.setId(102);
        e2.setMontant(37000);

      
        l.addUneEnchere(e1);
        l.addUneEnchere(e2);

    
        System.out.println("Lot numero : " + l.getId() 
                + " ; Prix de depart: " + l.getPrixDepart()
                + " ; Vente associée : " + l.getVente().getId() + " - " + l.getVente().getNom());

       
        System.out.println("Enchères pour ce lot :");
        for (Enchere e : l.getLesEncheres()) {
            System.out.println(" -> Enchère " + e.getId() + " | Montant : " + e.getMontant());
        }
    }
}
