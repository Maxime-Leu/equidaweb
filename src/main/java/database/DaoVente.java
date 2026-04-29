package database;

import model.Lieu;
import model.Vente;
import model.CategVente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DaoVente {
    
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    /**
     * Récupère la liste de toutes les ventes
     */
    public static ArrayList<Vente> getLesVentes(Connection cnx) {
        ArrayList<Vente> lesVentes = new ArrayList<Vente>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT vente.id, vente.nom, vente.dateDebutVente, " +
                "lieu.id, lieu.ville " +
                "FROM vente " +
                "JOIN lieu ON vente.lieu_id = lieu.id " +
                "ORDER BY vente.dateDebutVente DESC"
            );
            resultatRequete = requeteSql.executeQuery();
            
            while (resultatRequete.next()) {
                Vente v = new Vente();
                v.setId(resultatRequete.getInt("vente.id"));
                v.setNom(resultatRequete.getString("vente.nom"));
                v.setDateDebutVente(resultatRequete.getDate("vente.dateDebutVente"));

                Lieu l = new Lieu();
                l.setId(resultatRequete.getInt("lieu.id"));
                l.setVille(resultatRequete.getString("lieu.ville"));
                v.setLieu(l);

                lesVentes.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur dans getLesVentes");
        }
        return lesVentes;
    }

    /**
     * Récupère une vente spécifique par son ID
     */
   public static Vente getLaVente(Connection cnx, int idVente) {
    Vente vente = null;
    try {
        requeteSql = cnx.prepareStatement(
            "SELECT vente.id, vente.nom, vente.dateDebutVente, " +
            "lieu.id, lieu.ville, " +
            "categvente.code, categvente.libelle " +
            "FROM vente " +
            "JOIN lieu ON vente.lieu_id = lieu.id " +
            "JOIN categvente ON vente.categvente_code = categvente.code " +
            "WHERE vente.id = ?"
        );
        requeteSql.setInt(1, idVente);
        resultatRequete = requeteSql.executeQuery();
        
        if (resultatRequete.next()) {
            vente = new Vente();
            vente.setId(resultatRequete.getInt("vente.id"));
            vente.setNom(resultatRequete.getString("vente.nom"));
            vente.setDateDebutVente(resultatRequete.getDate("vente.dateDebutVente"));

            Lieu lieu = new Lieu();
            lieu.setId(resultatRequete.getInt("lieu.id"));
            lieu.setVille(resultatRequete.getString("lieu.ville"));
            vente.setLieu(lieu);

            CategVente categ = new CategVente();
            categ.setId(resultatRequete.getInt("categvente.code"));
            categ.setLibelle(resultatRequete.getString("categvente.libelle"));
            vente.setCategVente(categ);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("Erreur dans getLaVente");
    }
    return vente;
}
    /**
     * Ajoute une nouvelle vente en base de données
     */
    public static boolean ajouterVente(Connection cnx, Vente vente) {
        try {
            requeteSql = cnx.prepareStatement(
                "INSERT INTO vente (nom, dateDebutVente, categvente_code, lieu_id) VALUES (?, ?, ?, ?)",
                PreparedStatement.RETURN_GENERATED_KEYS
            );

            requeteSql.setString(1, vente.getNom());

            // Conversion Date util vers Date sql
            if (vente.getDateDebutVente() != null) {
                java.sql.Date sqlDate = new java.sql.Date(vente.getDateDebutVente().getTime());
                requeteSql.setDate(2, sqlDate);
            } else {
                requeteSql.setNull(2, java.sql.Types.DATE);
            }

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
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de l'ajout de la vente");
        }
        return false;
    }

    /**
     * Met à jour une vente existante
     */
    public static void updateVente(Connection cnx, Vente v) {
        try {
            requeteSql = cnx.prepareStatement(
                "UPDATE vente SET nom = ?, dateDebutVente = ?, lieu_id = ?, categvente_code = ? WHERE id = ?"
            );
            requeteSql.setString(1, v.getNom());

           
            if (v.getDateDebutVente() != null) {
                java.sql.Date sqlDate = new java.sql.Date(v.getDateDebutVente().getTime());
                requeteSql.setDate(2, sqlDate);
            } else {
                requeteSql.setNull(2, java.sql.Types.DATE);
            }

            requeteSql.setInt(3, v.getLieu().getId());
            requeteSql.setInt(4, v.getCategVente().getId()); 
            requeteSql.setInt(5, v.getId());
            
            requeteSql.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de l'update de la vente");
        }
    }
}