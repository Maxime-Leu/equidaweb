package model;

import java.util.ArrayList;

public class CategVente {

    private int id ;
    private String libelle;
    
    
    private ArrayList<Vente> lesVentes;

   

    public CategVente() {
    }

    public CategVente(int id, String libelle) {
        this.id = id;
        this.libelle = libelle;
    }

    public int getId() {
        return id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public ArrayList<Vente> getLesVentes() {
        return lesVentes;
    }

    public void setLesVentes(ArrayList<Vente> lesVentes) {
        this.lesVentes = lesVentes;
    }

    public void addUneVente(Vente uneVente){
        if (lesVentes == null){
            lesVentes = new ArrayList<Vente>();
        }
        lesVentes.add(uneVente);
    }
    
    

    
}
