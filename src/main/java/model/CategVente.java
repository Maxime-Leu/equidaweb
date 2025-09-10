package model;



public class CategVente {

    private int id ;
    private String libelle;
    

   

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

   
    

    
}
