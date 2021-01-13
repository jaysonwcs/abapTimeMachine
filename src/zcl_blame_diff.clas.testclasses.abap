*"* use this source file for your ABAP unit test classes
CLASS ltcl_diff DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    data: o_diff type ref to zcl_blame_diff.
    METHODS:
      setup,
      changed_line FOR TESTING RAISING cx_static_check,
      ignore_case FOR TESTING RAISING cx_static_check,
      ignore_indentation FOR TESTING RAISING cx_static_check,
      empty_old FOR TESTING RAISING cx_static_check,
      empty_both FOR TESTING RAISING cx_static_check,
      empty_new FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_diff IMPLEMENTATION.
  method setup.
    o_diff = new #( ).
  ENDMETHOD.


  METHOD changed_line.
    DATA(t_blame) = o_diff->compute( it_old   = VALUE #( ( source = 'AaA' author = 'A' ) )
                                     it_new   = VALUE #( ( source = 'aAa' author = 'B' ) ) ).
    cl_abap_unit_assert=>assert_equals( act = t_blame[ 1 ]-author
                                        exp = 'B' ).
  ENDMETHOD.


  METHOD ignore_case.
    zcl_blame_options=>get_instance( )->set( i_ignore_case = abap_true ).
    DATA(t_blame) = o_diff->compute( it_old   = VALUE #( ( source = 'AaA' author = 'A' ) )
                                     it_new   = VALUE #( ( source = 'aAa' author = 'B' ) ) ).
    cl_abap_unit_assert=>assert_equals( act = t_blame[ 1 ]-author
                                        exp = 'A' ).
  ENDMETHOD.


  METHOD ignore_indentation.
    zcl_blame_options=>get_instance( )->set( i_ignore_indentation = abap_true ).
    DATA(t_blame) = o_diff->compute( it_old   = VALUE #( ( source = '  AaA' author = 'A' ) )
                                     it_new   = VALUE #( ( source = '    AaA' author = 'B' ) ) ).
    cl_abap_unit_assert=>assert_equals( act = t_blame[ 1 ]-author
                                        exp = 'A' ).
  ENDMETHOD.


  METHOD empty_old.
    DATA(t_blame) = o_diff->compute( it_old   = VALUE #( )
                                     it_new   = VALUE #( ( source = 'bbb' author = 'B' )
                                                         ( source = 'bbb' author = 'B' ) ) ).
    cl_abap_unit_assert=>assert_equals( act = t_blame[ 1 ]-author
                                        exp = 'B' ).
    cl_abap_unit_assert=>assert_equals( act = lines( t_blame )
                                        exp = 2 ).
  ENDMETHOD.


  METHOD empty_new.
    DATA(t_blame) = o_diff->compute( it_old   = VALUE #( ( source = 'bbb' author = 'B' )
                                                         ( source = 'bbb' author = 'B' ) )
                                     it_new   = VALUE #( ) ).
    cl_abap_unit_assert=>assert_equals( act = lines( t_blame )
                                        exp = 0 ).
  ENDMETHOD.


  METHOD empty_both.
    DATA(t_blame) = o_diff->compute( it_old   = VALUE #( )
                                     it_new   = VALUE #( ) ).
    cl_abap_unit_assert=>assert_equals( act = lines( t_blame )
                                        exp = 0 ).
  ENDMETHOD.
ENDCLASS.
