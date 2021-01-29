CLASS zcl_03_a_issue_message DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_a_supercl_simple
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  METHODS /bobf/if_frw_action~execute



    REDEFINITION .
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS zcl_03_a_issue_message IMPLEMENTATION.


  METHOD /bobf/if_frw_action~execute.
    DATA lo_msg TYPE REF TO cm_d435b_travel.
  IF eo_message IS NOT BOUND.
    eo_message = /bobf/cl_frw_message_factory=>create_container(  ).
  ENDIF.

    create object lo_msg
        exporting
            textid = cm_d435b_travel=>cm_d435b_travel
            severity = cm_d435b_travel=>co_severity_success.

    eo_message->add_cm( io_message = lo_msg ).
    ev_static_action_failed = abap_false.

  ENDMETHOD.
ENDCLASS.
