<?php
namespace App\Controllers;

use Framework\Database;
use Framework\Session;
use Framework\Validation;
use Framework\Authorization;


class ListingController{
    protected $db;

    public function __construct(){
        $config = require basePath('config/db.php');
        $this->db = new Database($config);
    }

    /**
    * Show Listings
    * 
    */

    public function index(){

        $listings = $this->db->query("SELECT * FROM listings ORDER BY created_at DESC")->fetchAll();


        loadView('listings/index', [
            'listings' =>$listings
        ]);
    }

    /**
    * Create Listings
    * 
    */

    public function create(){

        loadView('listings/create');
    }

    /**
    * Show Single Listings
    *
    * @param array $params
    * @return void
    * 
    */

    public function show($params){
         
        $id = $params['id'] ?? '';

        $params = [
            'id' => $id
        ];
        $listing = $this->db->query("SELECT * FROM listings WHERE id = :id", $params)->fetch();

        // Check if Listings exists
        if(!$listing){
            ErrorController::notfound('Listing not found');
            return;
        }

        loadView('listings/show',[
            'listing' => $listing
        ]);
    }
    
    
    /**
    * Store data in database
    * @return void
    */

    public function store(){
        $allowedFields = ['title', 'description', 'salary', 'tags', 'company', 'address', 'city', 'state', 'phone', 'email', 'requirements', 'benefits'];

        $newListingsData = array_intersect_key($_POST, array_flip($allowedFields));

        $newListingsData['user_id'] = Session::get('user')['id'];

        $newListingsData = array_map('sanitize', $newListingsData);

        $requiredFields = ['title', 'description', 'salary', 'email', 'city', 'state'];

        $errors = [];

        foreach($requiredFields as $fields){
            if(empty($newListingsData[$fields]) || !Validation::string($newListingsData[$fields])){
                $errors[$fields] = ucfirst($fields) . ' is required';

            }
        }
        if(!empty($errors)){
            // Reload views with error
            loadView('listings/create', [
                'errors' => $errors,
                'listings' => $newListingsData
            ]);
        }else{
            // Submit data 

            $fields = [];

            foreach($newListingsData as $field => $value){
                $fields[] = $field;
            }

            $fields = implode(', ', $fields);

            $values = [];

            foreach($newListingsData as $field => $value){
                // Convert empty string to null
                if($value === ''){
                    $newListingsData[$field] = null;
                }
                $values[] = ':' . $field;

            }
            $values = implode(', ', $values);

            $query = "INSERT INTO listings ({$fields}) VALUES ({$values})";

            $this->db->query($query, $newListingsData);

            Session::setFlashMessage('success_message', 'Listings Created successfully');


            redirect('/listings');
        }


        inspectAndDie($newListingsData);
    }


    /**
     * Delete a listings 
     * 
     * @param array $params
     * @return void
     * 
     */


     public function destroy($params){
        $id = $params['id'];

        $params = [
            'id' => $id
        ];

        $listing = $this->db->query("SELECT * FROM listings WHERE id = :id", $params)->fetch();
        
        // Check if listings Exists
        if(!$listing){
            ErrorController::notfound('Listing not found');
            return;

        }

        // Authorization
        if(!Authorization::isOwner($listing->user_id)){
            Session::setFlashMessage('error_message', 'You are not authorize to delete this listing');
            return redirect('/listings/' . $listing->id);
        }

        $this->db->query("DELETE FROM listings WHERE id = :id", $params);

        // Set flash message
        Session::setFlashMessage('success_message', 'Listings deleted successfully');

        redirect('/listings');
     }

    /**
     * Show the listings edit form 
     * 
     * @param array $params
     * @return void
     * 
     */

     
    public function edit($params){
         
        $id = $params['id'] ?? '';

        $params = [
            'id' => $id
        ];
        $listing = $this->db->query("SELECT * FROM listings WHERE id = :id", $params)->fetch();

        // Check if Listings exists
        if(!$listing){
            ErrorController::notfound('Listing not found');
            return;
        }

           // Authorization
           if(!Authorization::isOwner($listing->user_id)){
            Session::setFlashMessage('error_message', 'You are not authorize to update this listing');
            return redirect('/listings/' . $listing->id);
        }
        

        loadView('listings/edit',[
            'listing' => $listing
        ]);
    }

     /**
     * Update a listings 
     * 
     * @param array $params
     * @return void
     * 
     */

     public function update($params){
        
        $id = $params['id'] ?? '';

        $params = [
            'id' => $id
        ];
        $listing = $this->db->query("SELECT * FROM listings WHERE id = :id", $params)->fetch();

        // Check if Listings exists
        if(!$listing){
            ErrorController::notfound('Listing not found');
            return;
        }

        // Authorization
        if(!Authorization::isOwner($listing->user_id)){
            Session::setFlashMessage('error_message', 'You are not authorize to update this listing');
            return redirect('/listings/' . $listing->id);
        }

        $allowedFields = ['title', 'description', 'salary', 'tags', 'company', 'address', 'city', 'state', 'phone', 'email', 'requirements', 'benefits'];

        $updateValues = [];
        
        $updateValues = array_intersect_key($_POST, array_flip($allowedFields));

        $updateValues = array_map('sanitize', $updateValues);

        $requiredFields = ['title', 'description', 'salary', 'email', 'city', 'state'];

        $errors = [];

        foreach($requiredFields as $field){
            if(empty($updateValues[$field]) || !Validation::string($updateValues[$field])){
                $errors[$field] = ucfirst($field) . 'is required';
            }
        }

        if(!empty($errors)){
            loadView('listings/edit',[
                'listing' => $listing,
                'errors' => $errors
            ]);
            exit;
        }else{
            // Submit to database
            $updateFields = [];
            foreach(array_keys($updateValues) as $field){
                $updateFields[] = "{$field} = :{$field}";
            }
            
            $updateFields = implode(', ', $updateFields);

            $updateQuery = "UPDATE listings SET $updateFields WHERE id = :id";

            $updateValues['id'] = $id;
            $this->db->query($updateQuery, $updateValues);

            // Set flash message
            Session::setFlashMessage('success_message', 'Listings Updated successfully');


            redirect('/listings/' . $id);

        }



     }

     /**
   * Search listings by keywords/location
   * 
   * @return void
   */
  public function search()
  {
    $keywords = isset($_GET['keywords']) ? trim($_GET['keywords']) : '';
    $location = isset($_GET['location']) ? trim($_GET['location']) : '';

    $query = "SELECT * FROM listings WHERE (title LIKE :keywords OR description LIKE :keywords OR tags LIKE :keywords OR company LIKE :keywords) AND (city LIKE :location OR state LIKE :location)";

    $params = [
      'keywords' => "%{$keywords}%",
      'location' => "%{$location}%"
    ];

    $listings = $this->db->query($query, $params)->fetchAll();

    loadView('/listings/index', [
      'listings' => $listings,
      'keywords' => $keywords,
      'location' => $location
    ]);
  }
}
