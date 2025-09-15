package test;

import model.Cheval;
import model.Course;
import model.ChevalCourse;
import model.Race;

public class TestChevalCourse {

    public static void main(String[] args) {
        // Création d'une race fictive
        Race race = new Race();
        race.setId(1);
        race.setNom("Pur-sang francais");

        // Création d'un cheval
        Cheval cheval = new Cheval();
        cheval.setId(1);
        cheval.setNom("Petit-Tonnerre");
        cheval.setDateNaissance("2015-04-10");
        cheval.setRace(race);

        // Création d'une course
        Course course = new Course(1, "Grand Prix de Paris", "Paris", "2023-06-20");

        // Création de la participation (ChevalCourse)
        ChevalCourse participation = new ChevalCourse(cheval, course, 1);

        // Affichage pour vérification
        System.out.println("Cheval : " + participation.getCheval().getNom());
        System.out.println("Course : " + participation.getCourse().getNom());
        System.out.println("Position : " + participation.getPosition());
    }
}
