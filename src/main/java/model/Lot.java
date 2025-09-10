package model;

import java.util.ArrayList;

public class Lot {

    private int id ;
    private int prixDepart;
    
    private Vente vente;
    private ArrayList<Enchere> lesEncheres;

    public Lot() {
    }

    public Lot(int id, int prixDepart) {
        this.id = id;
        this.prixDepart = prixDepart;
    }
    

    
    
    public int getId() {
        return id;
    }

    public int getPrixDepart() {
        return prixDepart;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setPrixDepart(int prixDepart) {
        this.prixDepart = prixDepart;
    }

    public Vente getVente() {
        return vente;
    }

    public void setVente(Vente vente) {
        this.vente = vente;
    }

    public ArrayList<Enchere> getLesEncheres() {
        return lesEncheres;
    }

    public void setLesEncheres(ArrayList<Enchere> lesEncheres) {
        this.lesEncheres = lesEncheres;
    }

    // méthode utilitaire pour ajouter une enchère
    public void addUneEnchere(Enchere uneEnchere) {
        if (lesEncheres == null) {
            lesEncheres = new ArrayList<>();
        }
        lesEncheres.add(uneEnchere);
        // on lie aussi l'enchère au lot
        uneEnchere.setLot(this);
    }
    
}