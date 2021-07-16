INTERFACE zif_timem_userexit
  PUBLIC .


  METHODS before_rendering
    IMPORTING
      !options TYPE REF TO zcl_timem_options
    CHANGING
      !data    TYPE ztimem_data .

  METHODS modify_results
    IMPORTING
      !options TYPE REF TO zcl_timem_options
    CHANGING
      !parts    TYPE ztimem_part_source_t
      !custom_fields TYPE ztimem_data_custom_fields.

  METHODS on_sapevent
    IMPORTING
      !options TYPE REF TO zcl_timem_options
      !action  TYPE c
      !getdata TYPE c .

  METHODS modify_part_list
    IMPORTING
      !options   TYPE REF TO zcl_timem_options
    CHANGING
      !part_list TYPE ztimem_part_t .

  METHODS modify_asset_content
    IMPORTING
      !options TYPE REF TO zcl_timem_options
      !subtype TYPE c
    CHANGING
      !content TYPE string .
ENDINTERFACE.
