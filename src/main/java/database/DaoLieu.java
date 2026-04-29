package database;



import model.Lieu;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DaoLieu {
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    /**
     * Récupère tous les lieux présents dans la base de données
     * @param cnx La connexion active à la base de données
     * @return ArrayList<Lieu> La liste de tous les lieux trouvés
     */
    public static ArrayList<Lieu> getLesLieux(Connection cnx) {
        ArrayList<Lieu> lesLieux = new ArrayList<Lieu>();
        try {
            // Requête SQL pour récupérer l'id et la ville (utilisés dans DaoVente)
            // Triés par ville pour un affichage propre dans le formulaire
            requeteSql = cnx.prepareStatement(
                "SELECT id, ville, nbBoxes FROM lieu ORDER BY ville"
            );
            resultatRequete = requeteSql.executeQuery();
            
            while (resultatRequete.next()) {
                Lieu lieu = new Lieu();
                lieu.setId(resultatRequete.getInt("id"));
                lieu.setVille(resultatRequete.getString("ville"));
                lieu.setNbBoxes(resultatRequete.getInt("nbBoxes"));
                
                lesLieux.add(lieu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesLieux a généré une exception SQL");
        }
        return lesLieux;
    }

    /**
     * Récupère un lieu spécifique par son identifiant
     * @param cnx La connexion active à la base de données
     * @param id L'identifiant du lieu recherché
     * @return Lieu Le lieu trouvé ou null si non trouvé
     */
    public static Lieu getLieuById(Connection cnx, int id) {
        Lieu lieu = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT id, ville, nbBoxes FROM lieu WHERE id = ?"
            );
            requeteSql.setInt(1, id);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
                lieu = new Lieu();
                lieu.setId(resultatRequete.getInt("id"));
                lieu.setVille(resultatRequete.getString("ville"));
                lieu.setNbBoxes(resultatRequete.getInt("nbBoxes"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLieuById a généré une exception SQL");
        }
        return lieu;
    }
}