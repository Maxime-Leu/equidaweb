package test;

import model.Cheval;
import model.Race;

public class TestRace
{
    public static void main (String args[]){
       
        Race r = new Race();
        r.setId(4);
        r.setNom("Andalou");

        
        Cheval c1 = new Cheval();
        c1.setId(1);
        c1.setNom("Eclipse");
        r.addCheval(c1);

        Cheval c2 = new Cheval();
        c2.setId(7);
        c2.setNom("Comète");
        r.addCheval(c2);

      
        System.out.println("La race est " + r.getId() + " " + r.getNom() + " et contient " + r.getLesChevaux().size() + " chevaux" );
        System.out.println("Liste des chevaux de la race : ");

		
        for (Cheval c : r.getLesChevaux()){
            System.out.println("Cheval numéro : " + c.getId() + " " + c.getNom());
        }
    }
}
