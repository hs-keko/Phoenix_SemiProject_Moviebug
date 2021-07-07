package moviebug.movieinfo.dto;

public class MovieDto {

   private int movie_num;
   private String movie_title_kr;
   private String movie_title_eng;
   private String movie_story;
   private String movie_character;
   private String movie_year;
   private String movie_genre;
   private String movie_company;
   private String movie_image;
   private String movie_trailer;
   private String movie_time;
   private String movie_rating;
   private String movie_nation;
   private String movie_director;
   
   public MovieDto() {}
   public MovieDto(int movie_num, String movie_title_kr, String movie_title_eng, String movie_story, 
         String movie_character, String movie_year, String movie_genre, String movie_company, 
         String movie_image, String movie_trailer, String movie_time, String movie_rating, String movie_nation, String movie_director) {
      super();
      this.movie_num = movie_num;
      this.movie_title_kr = movie_title_kr;
      this.movie_title_eng = movie_title_eng;
      this.movie_story = movie_story;
      this.movie_character = movie_character;
      this.movie_year = movie_year;
      this.movie_genre = movie_genre;
      this.movie_rating = movie_rating;
      this.movie_image = movie_image;
      this.movie_trailer = movie_trailer;
      this.movie_time = movie_time;
      this.movie_rating = movie_rating; 
   }
   public int getMovie_num() {
      return movie_num;
   }
   public void setMovie_num(int movie_num) {
      this.movie_num = movie_num;
   }
   public String getMovie_title_kr() {
      return movie_title_kr;
   }
   public void setMovie_title_kr(String movie_title_kr) {
      this.movie_title_kr = movie_title_kr;
   }
   public String getMovie_title_eng() {
      return movie_title_eng;
   }
   public void setMovie_title_eng(String movie_title_eng) {
      this.movie_title_eng = movie_title_eng;
   }
   public String getMovie_story() {
      return movie_story;
   }
   public void setMovie_story(String movie_story) {
      this.movie_story = movie_story;
   }
   public String getMovie_character() {
      return movie_character;
   }
   public void setMovie_character(String movie_character) {
      this.movie_character = movie_character;
   }
   public String getMovie_year() {
      return movie_year;
   }
   public void setMovie_year(String movie_year) {
      this.movie_year = movie_year;
   }
   public String getMovie_genre() {
      return movie_genre;
   }
   public void setMovie_genre(String movie_genre) {
      this.movie_genre = movie_genre;
   }
   public String getMovie_company() {
      return movie_company;
   }
   public void setMovie_company(String movie_company) {
      this.movie_company = movie_company;
   }
   public String getMovie_image() {
      return movie_image;
   }
   public void setMovie_image(String movie_image) {
      this.movie_image = movie_image;
   }
   public String getMovie_trailer() {
      return movie_trailer;
   }
   public void setMovie_trailer(String movie_trailer) {
      this.movie_trailer = movie_trailer;
   }
   public String getMovie_time() {
      return movie_time;
   }
   public void setMovie_time(String movie_time) {
      this.movie_time = movie_time;
   }
   public String getMovie_rating() {
      return movie_rating;
   }
   public void setMovie_rating(String movie_rating) {
      this.movie_rating = movie_rating;
   }
public String getMovie_nation() {
	return movie_nation;
}
public void setMovie_nation(String movie_nation) {
	this.movie_nation = movie_nation;
}
public String getMovie_director() {
	return movie_director;
}
public void setMovie_director(String movie_director) {
	this.movie_director = movie_director;
}
   
}




