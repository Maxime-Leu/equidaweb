package model;



public class Enchere {

    private int id ;
    private int montant;
    
    
    private Lot lot;    

    public Lot getLot() {
        return lot;
    }

    public Enchere() {
    }

    public int getId() {
        return id;
    }

    public int getMontant() {
        return montant;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setMontant(int montant) {
        this.montant = montant;
    }

    public void setLot(Lot lot) {
        this.lot = lot;
    }

   

    
}