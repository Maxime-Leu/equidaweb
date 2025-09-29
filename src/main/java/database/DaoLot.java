package database;

import model.Cheval;
import model.Race;
import model.Lot;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DaoLot {
    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;
    
    public static ArrayList<Cheval> getChevauxEnVente(Connection cnx, int idVente) {
        ArrayList<Cheval> chevaux = new ArrayList<>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT cheval.id, cheval.nom, cheval.sexe, cheval.sire, cheval.dateNaissance, " +
                "race.id race_id, race.libelle race_libelle, vente.nom, vente.id, vente.dateDebutVente, " +
                "lot.id, lot.prixDepart, lot.vente_id, lot.cheval_id, vente.lieu_id " +
                "FROM cheval " +
                "JOIN lot ON cheval.id = lot.cheval_id " +
                "JOIN race ON cheval.race_id = race.id " +
                "JOIN vente ON lot.vente_id = vente.id " +
                "WHERE lot.vente_id = ?"
            );
            requeteSql.setInt(1, idVente);
            System.out.println("req"+ requeteSql);
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Cheval cheval = new Cheval();
                cheval.setId(resultatRequete.getInt("cheval.id"));
                cheval.setNom(resultatRequete.getString("cheval.nom"));
                cheval.setSexe(resultatRequete.getString("cheval.sexe"));
                cheval.setSire(resultatRequete.getString("cheval.sire"));
                cheval.setDateNaissance(resultatRequete.getDate("cheval.dateNaissance"));

                Race race = new Race();
                race.setId(resultatRequete.getInt("race_id"));
                race.setNom(resultatRequete.getString("race_libelle"));
                cheval.setRace(race);

            chevaux.add(cheval);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de la récupération des chevaux en vente");
        }
        return chevaux;
    }
}

