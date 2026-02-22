@Regression
Feature: Automatizar el backend de PetStore

  #32
  Background:
    * url apiPetStore
    * def jsonCrearMascota = read('classpath:examples/jsonData/crearMascota.json')
    * def jsonActualizarMascota = read('classpath:examples/jsonData/actualizarMascota.json')

    @T-1 @happypath
  Scenario: Verificar la creación de una nueva mascota Pet Store
      Given path 'pet'
      And request jsonCrearMascota
      When method post
      Then status 200
      And match response.id == 14
      And match response.name == 'doggie'
      And match response.status == 'available'
      And print response
      * def idPet = response.id

    @T-2 @happypathh
  Scenario Outline: Verificar el estado de la mascota <estado> Pet Store
    Given path 'pet/findByStatus'
    And param status = '<estado>'
    When method get
    Then status 200
    And print response

    Examples:
      | estado    |
      | available |
      | sold      |
      | pending   |

    @T-3 @happypathh
  Scenario: Verificar la actualización de una mascota Pet Store
      Given path 'pet'
      And request jsonActualizarMascota.id = '3'
      And request jsonActualizarMascota
      When method put
      Then status 200

  @T-4 @happypath
  Scenario: Verificar una mascota por su ID
    * def crearMascota = call read('users.feature@T-1')
    Given path 'pet/' + crearMascota.idPet
    When method get
    Then status 200
    And print response

  @T-5 @happypathh
  Scenario Outline: Validar eliminar a una mascota por su ID
    Given path 'pet/' + '<idPet>'
    When method delete
    Then status 200
    And print response

    Examples:
      | idPet|
      | 1    |
      | 2    |
      | 3    |

  #Scenario: Verificar que se suba una imagen mediante el id de la mascota - OK
   # * def petId = 4

    #Given path 'pet', petId, 'uploadImage'
    #And multipart file file = { read: 'perrito.jpg', filename: 'perrito.jpg', contentType: 'image/jpeg' }
    #And multipart field additionalMetadata = 'Foto de perfil actualizada'
    #When method post
    #Then status 200
    #And match response.message contains 'perrito.jpg'



  # LLAMAR CASO DE PRUEBAS PARA USARLO DESPUES
