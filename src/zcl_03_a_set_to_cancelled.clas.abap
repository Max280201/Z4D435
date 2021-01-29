CLASS zcl_03_a_set_to_cancelled DEFINITION
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



CLASS zcl_03_a_set_to_cancelled IMPLEMENTATION.


  METHOD /bobf/if_frw_action~execute.

    DATA lo_msg TYPE REF TO cm_devs4d435.
    DATA ld_location TYPE /bobf/s_frw_location.

    DATA lt_travel TYPE d435b_t_itraveltp.

    DATA lr_travel TYPE REF TO d435b_s_itraveltp.
    FIELD-SYMBOLS <ls_travel> TYPE d435b_s_itraveltp.

    io_read->retrieve(
    EXPORTING
        iv_node   = is_ctx-node_key
        it_key    =  it_key

        IMPORTING
            et_data   = lt_travel ).

    IF eo_message IS NOT BOUND.
        eo_message = /bobf/cl_frw_message_factory=>create_container(  ).
    ENDIF.

    LOOP AT lt_travel ASSIGNING <ls_travel>.

        ld_location-bo_key = is_ctx-bo_key.
        ld_location-node_key = is_ctx-node_key.
        ld_location-key = <ls_travel>-key.

        IF <ls_travel>-status = 'C'. " already cancelled

            CREATE OBJECT lo_msg
                EXPORTING
                    textid  = cm_devs4d435=>already_cancelled
                    severity = cm_devs4d435=>co_severity_error
*                   lifetime =
                    travelnumber = <ls_travel>-travelnumber
                    ms_origin_location = ld_location.
                    eo_message->add_cm(  io_message = lo_msg ).

        ELSE.
            <ls_travel>-status = 'C'.

            GET REFERENCE OF <ls_travel> INTO lr_travel.

            io_modify->update(
            exporting
                iv_node = is_ctx-node_key
                iv_key = <ls_travel>-key
                is_data = lr_travel ).



            create object lo_msg
              exporting
                textid  = cm_devs4d435=>cancel_success
                severity = cm_devs4d435=>co_severity_success
                travelnumber = <ls_travel>-travelnumber
                startdate = <ls_travel>-startdate
                ms_origin_location = ld_location.

                eo_message->add_cm(  io_message = lo_msg ).
                endif.
          endloop.
  ENDMETHOD.
ENDCLASS.
