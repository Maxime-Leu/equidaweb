package model;

import java.util.ArrayList;
import java.util.Date;

public class Cheval {

    private int id;
    private String nom;
    private Date dateNaissance; 
    private String sire;
    private String sexe;

    private Race race;
    private ArrayList<Cheval> LesChevauxParents;

    public Cheval() {
    }

    public void setSire(String sire) {
        this.sire = sire;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getSire() {
        return sire;
    }

    public String getSexe() {
        return sexe;
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

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(Date dateNaissance) {
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
