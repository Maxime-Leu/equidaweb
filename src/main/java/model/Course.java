package model;



public class Course {

    private int id ;
    private String nom;
    private String lieu;
    private String date;

    public Course(int id, String nom, String lieu, String date) {
        this.id = id;
        this.nom = nom;
        this.lieu = lieu;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public String getLieu() {
        return lieu;
    }

    public String getDate() {
        return date;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    
}

