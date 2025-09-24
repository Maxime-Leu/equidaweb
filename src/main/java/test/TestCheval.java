package test;

import model.Cheval;
import model.Race;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TestCheval {

    public static void main(String args[]) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            Cheval c = new Cheval();
            c.setId(2);
            c.setNom("Houri");

            Race r = new Race();
            r.setId(1);
            r.setNom("pur-sang");

            Cheval mere = new Cheval();
            mere.setId(1);
            mere.setNom("Antonin");
            mere.setDateNaissance(sdf.parse("2000-01-01")); 

            Cheval pere = new Cheval();
            pere.setId(1);
            pere.setNom("Sabrina");
            pere.setDateNaissance(sdf.parse("2000-01-01"));  

            c.setRace(r);
            mere.setRace(r);
            pere.setRace(r);

            c.addUnChevalParent(pere);
            c.addUnChevalParent(mere);

            System.out.println("Cheval : " + c.getId() + " " + c.getNom() + " "
                    + c.getRace().getId() + " " + c.getRace().getNom());

            System.out.println("Parents du cheval " + c.getNom() + " :");

            System.out.println("- Mère : " + mere.getId() + " " + mere.getNom() + " "
                    + mere.getDateNaissance() + " Race : " + mere.getRace().getNom());

            System.out.println("- Père : " + pere.getId() + " " + pere.getNom() + " "
                    + pere.getDateNaissance() + " Race : " + pere.getRace().getNom());
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
