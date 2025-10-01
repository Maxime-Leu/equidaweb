package database;

import model.Cheval;
import model.Race;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.ChevalCourse;
import model.Course;

public class DaoCheval {
    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

   
    public static ArrayList<Cheval> getLesChevaux(Connection cnx) {
        ArrayList<Cheval> lesChevaux = new ArrayList<Cheval>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT cheval.id AS cheval_id, cheval.nom, cheval.dateNaissance, " +
                "race.id , race.libelle " +
                "FROM cheval " +
                "JOIN race ON cheval.race_id = race.id; "
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Cheval c = new Cheval();
                c.setId(resultatRequete.getInt("cheval_id"));
                c.setNom(resultatRequete.getString("cheval.nom"));
                c.setDateNaissance(resultatRequete.getDate("cheval.dateNaissance"));
                Race r = new Race();
                r.setId(resultatRequete.getInt("race.id"));
                r.setNom(resultatRequete.getString("race.libelle"));
                c.setRace(r);
                lesChevaux.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesChevaux a généré une exception SQL");
        }
        return lesChevaux;
    }

    
    public static Cheval getLeCheval(Connection cnx, int idCheval) {
    Cheval cheval = null;
    try {
        requeteSql = cnx.prepareStatement(
            "SELECT c.id AS cheval_id, c.nom AS cheval_nom, c.dateNaissance, c.sexe, c.sire, " +
            "r.id AS race_id, r.libelle AS race_nom, " +
            "pere.id AS pere_id, pere.nom AS pere_nom, " +
            "mere.id AS mere_id, mere.nom AS mere_nom " +
            "FROM cheval c " +
            "JOIN race r ON c.race_id = r.id " +
            "JOIN cheval pere ON c.pere_id = pere.id " +
            "JOIN cheval mere ON c.mere_id = mere.id " +
            "WHERE c.id = ?"
        );

        requeteSql.setInt(1, idCheval);
        resultatRequete = requeteSql.executeQuery();

        if (resultatRequete.next()) {
            cheval = new Cheval();
            cheval.setId(resultatRequete.getInt("cheval_id"));
            cheval.setNom(resultatRequete.getString("cheval_nom"));
            cheval.setDateNaissance(resultatRequete.getDate("dateNaissance"));
            cheval.setSexe(resultatRequete.getString("sexe"));
            cheval.setSire(resultatRequete.getString("sire"));

          
            Race race = new Race();
            race.setId(resultatRequete.getInt("race_id"));
            race.setNom(resultatRequete.getString("race_nom"));
            cheval.setRace(race);

            
            Cheval pere = new Cheval();
            pere.setId(resultatRequete.getInt("pere_id"));
            pere.setNom(resultatRequete.getString("pere_nom"));
            cheval.setChevalPere(pere);

           
            Cheval mere = new Cheval();
            mere.setId(resultatRequete.getInt("mere_id"));
            mere.setNom(resultatRequete.getString("mere_nom"));
            cheval.setChevalMere(mere);
        }

    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("La requête de getLeCheval a généré une exception SQL");
    }

        return cheval;
    }


    public static boolean ajouterCheval(Connection cnx, Cheval cheval) {
    try {
        requeteSql = cnx.prepareStatement(
            "INSERT INTO cheval (nom, sexe, sire, dateNaissance, race_id) VALUES (?, ?, ?, ?, ?)",
            PreparedStatement.RETURN_GENERATED_KEYS
        );
        requeteSql.setString(1, cheval.getNom());
        requeteSql.setString(2, cheval.getSexe());  
        requeteSql.setString(3, cheval.getSire());  

        
        if (cheval.getDateNaissance() != null) {
            java.util.Date utilDate = cheval.getDateNaissance();
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            requeteSql.setDate(4, sqlDate);
        } else {
            requeteSql.setNull(4, java.sql.Types.DATE);
        }

       
        requeteSql.setInt(5, cheval.getRace().getId());

        int result = requeteSql.executeUpdate();

        if (result == 1) {
            ResultSet rs = requeteSql.getGeneratedKeys();
            if (rs.next()) {
                cheval.setId(rs.getInt(1));
            }
            return true;
        }
        return false;

    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("Erreur lors de l'ajout du cheval");
        return false;
    }
} 
    
    public static ArrayList<ChevalCourse> getLesCoursesByCheval(Connection cnx, int idCheval) {
    ArrayList<ChevalCourse> chevalCourses = new ArrayList<>();

    try {
        requeteSql = cnx.prepareStatement(
            "SELECT cc.position, c.nom AS course_nom, c.date AS course_date " +
            "FROM cheval_course cc " +
            "JOIN course c ON cc.course_id = c.id " +
            "WHERE cc.cheval_id = ?"
        );
        requeteSql.setInt(1, idCheval);
        resultatRequete = requeteSql.executeQuery();

        while (resultatRequete.next()) {
         
            ChevalCourse chevalCourse = new ChevalCourse();
            chevalCourse.setPosition(resultatRequete.getInt("cc.position"));

           
            Course course = new Course();
            course.setNom(resultatRequete.getString("course_nom"));
            course.setDate(resultatRequete.getDate("course_date"));

            chevalCourse.setCourse(course);
            chevalCourses.add(chevalCourse);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("La requête de getLesCoursesByCheval a généré une exception SQL");
    }

    return chevalCourses;
}
   
}




