package test;

import model.Vente;
import model.CategVente;
import model.Lieu;

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
        
        Lieu l = new Lieu();
        l.setId(1);
        l.setVille("Porte de Clignancourt");
        l.setNbBoxes(100);

        //relations ManyToOne
        v.setCategVente(c);
        v1.setLieu(l);

        // Affichage des informations dans la console
        
        System.out.println("Vente : " + v.getId() + " " + v.getNom() + " "
                + v.getCategVente().getId() + " " + v.getCategVente().getLibelle() + " " + v1.getLieu().getVille());
        
        
    }
}
