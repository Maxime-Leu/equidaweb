package model;


import java.util.ArrayList;

public class Cheval {

    private int id;
    private String nom;
    private String dateNaissance;

    private Race race;
    private ArrayList<Cheval> LesChevauxParents;
   

    public Cheval() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(String dateNaissance) {
        this.dateNaissance = dateNaissance;
    }
    public Race getRace() {
        return race;
    }
    public void setRace(Race race) {
        this.race = race;
    }
    
    public ArrayList<Cheval> getLesChevauxParents() {
        return LesChevauxParents;
    }

    public void setLesCheveauxParents(ArrayList<Cheval> LesChevauxParents) {
        this.LesChevauxParents = LesChevauxParents;
    }

    
    public void addUnChevalParent(Cheval unChevalParent) {
        if (LesChevauxParents == null) {
            LesChevauxParents = new ArrayList<>();
        }
        LesChevauxParents.add(unChevalParent);
        
       
    }

   

   
}
