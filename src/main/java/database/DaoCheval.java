package database;

import model.Cheval;
import model.Race;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DaoCheval {
    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    /**
     * Récupère tous les chevaux présents dans la base de données avec leurs races associées
     */
    public static ArrayList<Cheval> getLesChevaux(Connection cnx) {
        ArrayList<Cheval> lesChevaux = new ArrayList<Cheval>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT cheval.id, cheval.nom, cheval.dateNaissance, " +
                "race.id , race.libelle " +
                "FROM cheval " +
                "JOIN race ON cheval.race_id = race.id; "
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Cheval c = new Cheval();
                c.setId(resultatRequete.getInt("cheval.id"));
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

    /**
     *  Récupère un cheval spécifique par son identifiant
     */
    public static Cheval getLeCheval(Connection cnx, int idCheval) {
        Cheval cheval = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT cheval.id , cheval.nom , cheval.dateNaissance, race.id , race.libelle  " +
                "FROM cheval  " +
                "JOIN race ON cheval.race_id = race.id " +
                "WHERE cheval.id = ?"
            );
            requeteSql.setInt(1, idCheval);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
                cheval = new Cheval();
                cheval.setId(resultatRequete.getInt("cheval.id"));
                cheval.setNom(resultatRequete.getString("cheval.nom"));
                cheval.setDateNaissance(resultatRequete.getDate("cheval.dateNaissance"));
                Race race = new Race();
                race.setId(resultatRequete.getInt("race.id"));
                race.setNom(resultatRequete.getString("race.libelle")); 
                cheval.setRace(race);
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

}
