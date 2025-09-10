package model;

import java.time.LocalDate;

public class Vente {

    private int id;
    private String nom;
    private LocalDate dateDebutVente;
    
    private CategVente categvente;
    private Lieu lieu;

    public Vente() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Vente(int id, String nom, LocalDate dateDebutVente) {
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

    public LocalDate getDebutVente() {
        return dateDebutVente;
    }

    public void setdateDebutVente(LocalDate dateDebutVente) {
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
    
    
    
}
