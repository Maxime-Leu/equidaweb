package database;

import model.CategVente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DaoCategVente {
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    /**
     * Récupère toutes les catégories de vente présentes dans la base de données
     * @param cnx La connexion active à la base de données
     * @return ArrayList<CategVente> La liste de toutes les catégories trouvées
     */
    public static ArrayList<CategVente> getLesCategVentes(Connection cnx) {
        ArrayList<CategVente> lesCategVentes = new ArrayList<CategVente>();
        try {
            // On récupère le code et le libellé (le nom de la table est déduit de DaoVente)
            requeteSql = cnx.prepareStatement(
                "SELECT code, libelle FROM categvente ORDER BY libelle"
            );
            resultatRequete = requeteSql.executeQuery();
            
            while (resultatRequete.next()) {
                CategVente uneCateg = new CategVente();
                // On utilise le "code" comme ID car ta table Vente utilise "categvente_code"
                uneCateg.setId(resultatRequete.getInt("code"));
                uneCateg.setLibelle(resultatRequete.getString("libelle"));
                
                lesCategVentes.add(uneCateg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesCategVentes a généré une exception SQL");
        }
        return lesCategVentes;
    }

    /**
     * Récupère une catégorie spécifique par son code (identifiant)
     * @param cnx La connexion active à la base de données
     * @param id L'identifiant (code) de la catégorie recherchée
     * @return CategVente La catégorie trouvée ou null si non trouvée
     */
    public static CategVente getCategVenteById(Connection cnx, int id) {
        CategVente uneCateg = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT code, libelle FROM categvente WHERE code = ?"
            );
            requeteSql.setInt(1, id);
            resultatRequete = requeteSql.executeQuery();
            
            if (resultatRequete.next()) {
                uneCateg = new CategVente();
                uneCateg.setId(resultatRequete.getInt("code"));
                uneCateg.setLibelle(resultatRequete.getString("libelle"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getCategVenteById a généré une exception SQL");
        }
        return uneCateg;
    }
}