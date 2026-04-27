/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author sio2
 */
public class DaoEnchere {
    // Récupérer le montant max actuel pour un lot
    public static int getMontantMaxLot(Connection con, int lot_id) {
        int max = 0;
        try {
            String sql = "SELECT MAX(montant) AS max_enchere FROM enchere WHERE id_lot = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, lot_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                max = rs.getInt("max_enchere");
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return max;
    }

    // Ajouter l'enchère
    public static void addEnchere(Connection con, int montant, int lot_id, int acheteur_id) {
        try {
            String sql = "INSERT INTO enchere (montant, id_lot, id_acheteur) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, montant);
            ps.setInt(2, lot_id);
            ps.setInt(3, acheteur_id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
