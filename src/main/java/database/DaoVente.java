package database;

import model.Lieu;
import model.Vente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DaoVente {
    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    /**
     * Récupère toutes les ventes présentes dans la base de données avec leur lieu associé
     */
    public static ArrayList<Vente> getLesVentes(Connection cnx) {
        ArrayList<Vente> lesVentes = new ArrayList<Vente>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT vente.id, vente.nom, vente.dateDebutVente, " +
                "lieu.id , lieu.ville " +
                "FROM vente " +
                "JOIN lieu ON vente.lieu_id = lieu.id"
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Vente v = new Vente();
                v.setId(resultatRequete.getInt("vente.id"));
                v.setNom(resultatRequete.getString("vente.nom"));

                // 🔁 Remplacement de String par Date
                v.setDateDebutVente(resultatRequete.getDate("vente.dateDebutVente"));

                Lieu l = new Lieu();
                l.setId(resultatRequete.getInt("lieu.id"));
                l.setVille(resultatRequete.getString("lieu.ville"));
                v.setLieu(l);

                lesVentes.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesVentes a généré une exception SQL");
        }
        return lesVentes;
    }

    /**
     * Récupère une vente par son identifiant
     */
    public static Vente getLaVente(Connection cnx, int idVente) {
        Vente vente = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT vente.id, vente.nom, vente.dateDebutVente, " +
                "lieu.id , lieu.ville " +
                "FROM vente " +
                "JOIN lieu ON vente.lieu_id = lieu.id " +
                "WHERE vente.id = ?"
            );
            requeteSql.setInt(1, idVente);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
                vente = new Vente();
                vente.setId(resultatRequete.getInt("vente.id"));
                vente.setNom(resultatRequete.getString("vente.nom"));

                // 🔁 Remplacement de String par Date
                vente.setDateDebutVente(resultatRequete.getDate("vente.dateDebutVente"));

                Lieu lieu = new Lieu();
                lieu.setId(resultatRequete.getInt("lieu.id"));
                lieu.setVille(resultatRequete.getString("lieu.ville"));
                vente.setLieu(lieu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLaVente a généré une exception SQL");
        }
        return vente;
    }

    /**
     * Ajoute une nouvelle vente dans la base de données
     */
    public static boolean ajouterVente(Connection cnx, Vente vente) {
        try {
            PreparedStatement requeteSql = cnx.prepareStatement(
                "INSERT INTO vente (nom, dateDebutVente, categvente_code, lieu_id) VALUES (?, ?, ?, ?)",
                PreparedStatement.RETURN_GENERATED_KEYS
            );

            requeteSql.setString(1, vente.getNom());

            // 🔁 Conversion java.util.Date -> java.sql.Date
            java.util.Date dateDebut = vente.getDateDebutVente();
            java.sql.Date sqlDateDebut = new java.sql.Date(dateDebut.getTime());
            requeteSql.setDate(2, sqlDateDebut);

            requeteSql.setInt(3, vente.getCategVente().getId());
            requeteSql.setInt(4, vente.getLieu().getId());

            int result = requeteSql.executeUpdate();

            if (result == 1) {
                ResultSet rs = requeteSql.getGeneratedKeys();
                if (rs.next()) {
                    vente.setId(rs.getInt(1));
                }
                return true;
            }

            return false;

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de l'ajout de la vente");
            return false;
        }
    }
}
