package model;


import java.util.ArrayList;
import model.Lot;

public class Vente {

    private int id;
    private String nom;
    private String dateDebutVente;
    
    private CategVente categvente;
    private Lieu lieu;
    private ArrayList<Lot> lesLots;

    public Vente() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Vente(int id, String nom, String dateDebutVente) {
        this.id = id;
        this.nom = nom;
        this.dateDebutVente = dateDebutVente;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDebutVente() {
        return dateDebutVente;
    }

    public void setdateDebutVente(String dateDebutVente) {
        this.dateDebutVente = dateDebutVente;
    }
    
    public CategVente getCategVente() {
        return categvente;
    }
    public void setCategVente(CategVente categvente) {
        this.categvente = categvente;
    }

    public Lieu getLieu() {
        return lieu;
    }

    public void setLieu(Lieu lieu) {
        this.lieu = lieu;
    }
    
    public ArrayList<Lot> getLesLots() {
        return lesLots;
    }

    public void setLesLots(ArrayList<Lot> lesLots) {
        this.lesLots = lesLots;
    }

    public void addUnLot(Lot unLot){
        if (lesLots == null){
            lesLots = new ArrayList<Lot>();
        }
        lesLots.add(unLot);
    }
    
    
}
