package test;

import model.Cheval;
import model.Course;
import model.ChevalCourse;
import model.Race;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TestChevalCourse {

    public static void main(String[] args) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

          
            Race race = new Race();
            race.setId(1);
            race.setNom("Pur-sang francais");

         
            Cheval cheval = new Cheval();
            cheval.setId(1);
            cheval.setNom("Petit-Tonnerre");
            cheval.setDateNaissance(sdf.parse("2015-04-10"));  
            cheval.setRace(race);

         
            Date dateCourse = sdf.parse("2023-06-20"); 
            Course course = new Course(1, "Grand Prix de Paris", "Paris", dateCourse);

           
            ChevalCourse participation = new ChevalCourse(cheval, course, 1);

    
            System.out.println("Cheval : " + participation.getCheval().getNom());
            System.out.println("Course : " + participation.getCourse().getNom());
            System.out.println("Position : " + participation.getPosition());
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
