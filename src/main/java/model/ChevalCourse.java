package model;

public class ChevalCourse {

    private Cheval cheval;
    private Course course;
    private int position;

    public ChevalCourse() {
    }

    public ChevalCourse(Cheval cheval, Course course, int position) {
        this.cheval = cheval;
        this.course = course;
        this.position = position;
    }

    public Cheval getCheval() {
        return cheval;
    }

    public void setCheval(Cheval cheval) {
        this.cheval = cheval;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }
}
