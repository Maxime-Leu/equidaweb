package model;



public class Lot {

    private int id ;
    private int prixDepart;
    
    private Vente vente;
   

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

    
    
}