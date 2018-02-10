#! /usr/bin/env wish

package require Itcl
package require Tk
package require sqlite3
package require BWidget
package require tablelist
package require Img
sqlite3 _time :memory:

if {[pwd]=="/home/hero/rx"} {
proc sdltk {args} {}
proc borg {args} {}
sqlite3 db "/home/hero/rx/romitex.db"
#sqlite3 reg "/home/hero/tcl/registros.db"
sqlite3 fem "/home/hero/femenino.db"
sqlite3 mas "/home/hero/masculino.db"
set dir "/home/hero/tcl/"
} {
#bind all <Key-Break> {borg withdraw} ;#Funciona perfecto la baja no la borra
borg screenorientation locked;# Funciona perfecto, locked orientacion
sdltk touchtranslate 1 ;#Dudoso, transformaria gestos pero no veo real resultado
sqlite3 db "/sdcard1/dia/romitex.db"
sqlite3 fem "/sdcard1/dia/femenino.db"
sqlite3 mas "/sdcard1/dia/masculino.db"
#sqlite3 reg "/sdcard/dia/registros.db"
#set dir "/sdcard/dia/planos/"
wm attributes . -fullscreen 1
}
#TODO futuro: agregar el shortcut. Me lo instala y se podria
#agregar como tercer argumento un png-icon de 48x48
#pero me dice la aplicacion no esta instalada
#borg shortcut add rx "/storage/emulated/0/dia/dni.tcl"
#
#LIBRERIAS PROPIAS
#=================================================================

proc unique {{id 0}} {
incr id
proc unique "{id $id}" [info body unique]
return $id
}
proc tabule {sel {db db}} {
    set tabla {}
    set lista [$db eval $sel]
    $db eval $sel a {break}
    set cnt [llength $a(*)]

    for {set i 0} {$i<[llength $lista]} {incr i $cnt} {
        lappend tabla [lrange $lista $i [expr $i+$cnt]]
        }
    return $tabla
}
itcl::class Uni {
  constructor {} {
}
public variable i 0
public method get {} {
incr i
return $i
}
}
proc uni {pathname} {
    uplevel Uni $pathname
}
proc hoy {} {
    return [_time eval "select date('now','localtime')"]
}
proc balloon {w arg {time 4000}} {
set top $w.balloon[unique]
catch {destroy $top}
toplevel $top -bd 0 -bg black
wm overrideredirect $top 1
pack [message $top.txt -aspect 10000 -bg yellow \
         -fg black -text $arg]
set wmx [winfo rootx $w]
if {[winfo class $w]=="Tablelist"} {
    #si es tablelist el balloon se pone arriba
set wmy [winfo rooty $w]} {
set wmy [expr [winfo rooty $w]+[winfo height $w]]
}
wm geometry $top \
  [winfo reqwidth $top.txt]x[winfo reqheight $top.txt]+$wmx+$wmy
raise $top
 after $time destroy $top
 bind $top <Leave> {destroy %W}
 }

proc cur {valor} {
    if {[regexp {\d.} $valor]} {
        return \$$valor
    }
}

proc range {from to} {
set rg {}
for {set i $from} {$i<$to} {incr i} {
lappend rg $i}
return $rg
}
option add *background grey17
option add *foreground white
option add *font {Helvetica 10}
option add *highlightColor      red
option add *selectBackground      orange
option add *selectForeground      black
option add *disabledBackground red4
option add *disabledForeground white
option add *relief                solid
option add *activeBackground     red4
option add *activeBorderWidth    2
option add *anchor               w
option add *highlightBackground  #333333
option add *highlightThickness 2
option add *padx                4
option add *troughColor        #333333
option add *Frame.highlightThickness 0
option add *Tablelist*background           #333333
option add *Tablelist*labelBackground       orange4
option add *Tablelist*labelActiveBackground orange
option add *Tablelist*labelFont       {Helvetica 8}
option add *Tablelist*labelForeground           black
option add *Tablelist*foreground           white
option add *Tablelist*stripeBackground           black
option add *Tablelist*selectBackground           yellow
option add *Tablelist*showSeparators          yes
option add *Tablelist*treeStyle               dust
option add *Tablelist*takeFocus              1
option add *Tablelist*labelCommand           tablelist::sortByColumn
option add *Tablelist*labelCommand2         tablelist::addToSortColumns
option add *Tablelist*tooltipAddCommand      tooltipAddCmd
option add *Tablelist*tooltipDelCommand      DynamicHelp::delete
option add *Tablelist*stretch         all
option add *Tablelist*editSelectedOnly         1
option add *Tablelist*font         {Helvetica 9}

proc tooltipAddCmd {tbl row col} {
    if {($row >= 0 && [$tbl iselemsnipped $row,$col fullText]) ||
        ($row <  0 && [$tbl istitlesnipped $col fullText])} {
        DynamicHelp::add $tbl -text $fullText
	DynamicHelp::configure -font {Helvetica 9} -background yellow -foreground black
    }
}


itcl::class Tbls {
    constructor {frame args} {
        set f [frame .f[unique]]
        set path [string range $this 2 end]
        set scv [scrollbar $f.scv -width 40 -orient vertical \
                 -command "$path yview" -bg grey17]
        set sch [scrollbar $f.sch -width 40 -orient horizontal \
                 -command "$path xview" -bg grey17]
        lappend args -yscrollcommand [list $scv set]
        lappend args -xscrollcommand [list $sch set]
        set t [eval tablelist::tablelist $path $args]
        pack $f -in $frame -fill both -expand yes
        pack $scv -fill y -side right -in $f
        pack $t -fill both  -in $f -expand yes
        pack $sch -fill x -side bottom -in $f

        #El conveniente automatismo de usar la class en forma "libre"
        #y "artesanal" o sea no ateniendome a la ortodoxia pero logrando
        #un fabuloso uso del tablelist como si no estuviera clasado fue
        #por sacar el $path para nombrar el tablelist como parte del nombre
        #de la clase.
        #p.e si yo hago
        #tbls $frame1 .tbls1 -wid ... en realidad se esta construyendo
        #un objeto Tbls de nombre ::.tbls1, solo que yo no uso el objeto
        #creado por nombre, pq una vez instanciado me hizo todo lo que yo
        #queria, que es crear un tbls, dos scroll y packearlos juntos
        #luego como al tbls creado dentro del constructor le puse por nombre
        #el mismo nombre .tbls1, eso es [string range $this 2 end] voile!!

    }
}

proc tbls {pathname frame args} {
    uplevel Tbls $pathname $frame $args
}


#
##COMIENZO DEL SCRIPT
#=================================================================


sdltk touchtranslate 1

#set date [db onecolumn "select date('now','localtime')"]

NoteBook .n  -width 1000 -height 1800

.n insert end vta -text "vta " -raisecmd {sdltk textinput off}
.n insert end cua -text "cua " -raisecmd {sdltk textinput 0 0 0}
.n insert end dni -text "dni"
#.n insert end reg -text "reg " -raisecmd {sdltk textinput off
                                        #llenaregistros
                                    #}
                                    #.n insert end pla -text "pla"
.n insert end tel -text "tel"
.n insert end bus -text "bus"  -raisecmd {sdltk textinput 0 0 0}
.n insert end bus1 -text "fts4"  -raisecmd {sdltk textinput 0 0 0}


set fdni [.n getframe dni]
set fvta [.n getframe vta]
set fcua [.n getframe cua]
#set freg [.n getframe reg]
set fpla [.n getframe pla]
set ftel [.n getframe tel]
set fbus [.n getframe bus]
set fbus1 [.n getframe bus1]

.n raise dni
pack .n -fill both





#
#PESTAÑA DNI
##=================================================================
uni photo
proc takephoto {} {
global dnibuscar
if {[info exists dnibuscar]} {
if {$dnibuscar!=""} {
set toma ${dnibuscar}_[photo get]
#image create photo $toma
    set filename [file join "/sdcard/dia/dni/" $toma.jpeg]
    borg activity android.media.action.IMAGE_CAPTURE {} {} {} {} \
       [list {Uri output} file://$filename]
}
}
}

#cuadro de busqueda unicamente por dni con teclado numerico
#y resultado abajo en dos tbls
pack [frame $fdni.fr] -fill x
entry $fdni.buscardni -textvariable dnientry -font {Helvetica 10 bold} \
                       -bg {light yellow} -fg blue -width 12
button $fdni.take -text Shot! -command takephoto

bind $fdni.buscardni <1> {
%W delete 0 end
sdltk textinput on 0 0 0
}
bind $fdni.buscardni <FocusIn> {
#%W selection range 0 end
sdltk textinput on 0 0 0
}
bind $fdni.buscardni <Double-1> {
%W delete 0 end
sdltk textinput on 0 0 0
}
puts [bind $fdni.buscardni <Double-1>]
focus $fdni.buscardni


bind $fdni.buscardni <Return> {
    focus .tdni1
    #introduzco puntos cada 3 cifras en el numero de dni
    #para comprobar que esta correcto
    set sep "."
    regsub {(\d*)(\d\d\d)(\d\d\d)$} $dnientry "\\1$sep\\2$sep\\3" dnientry
    regsub -all {\.} $dnientry "" dnibuscar;#limpio los . --> dnibuscar

    sdltk textinput off
    .tdni1 delete 0 end
    .tdni1 columnconfigure 1 -bg {light yellow} -fg black
    .tdni2 delete 0 end
    #inteligencia de busqueda en clientes /padron etc
    #PRIMERO busco en tabla clientes
    if {[string first "-" $dnibuscar]==0} {
        set dnibuscar [string range $dnibuscar 1 end]
        if {[buscacliente $dnibuscar]==0} {buscamas $dnibuscar}
    } { if {[buscacliente $dnibuscar]==0} {buscafem $dnibuscar}
    }



#registro la busqueda
#if {$dnibuscar!=""} {
#reg eval "insert into buscados(dni,nombre,fecha) values
                        #(:dnibuscar,:nombre,datetime('now','localtime'))"
                    #}
#}
proc buscacliente {dni} {
    global nombre regdni fdni casadni
    #puts "busco cliente $dni"
    if {[db exist "select * from clientes where dni =:dni"]} {
        db eval {select dni,nombre,calle,num,zona,deuda,ultpago,\
        comprado,ultcompra,comentarios,barrio,acla,tel,excalle,exnum,id  \
        from clientes where dni= :dni} a {
            set regdni [lmap x $a(*) {list $x $a($x)}]
            set nombre $a(nombre);# para la tabla buscados en registros
#ver doc sobre esta tecnica
        #coloraciones de acuerdo a datos que hay que resaltar en zona
        if {$a(deuda)>0} {.tdni1 rowconfigure 5 -bg red -fg white}
        if {$a(comprado)>0 && $a(deuda)==0} {.tdni1 \
                                      rowconfigure 7 -bg blue -fg white}
        if {[string index $a(zona) 0]=="-"} {.tdni1 \
                                      rowconfigure 4 -bg magenta -fg black}
        #verifico y lleno list de casadni a los otros clientes de la direccion
        set casadni [tabule "select deuda,nombre,dni,ultpago,comprado,ultcompra, \
                            zona,comentarios,tel,acla,id from clientes\
                            where calle='$a(calle)'\
                            and num=$a(num) and dni!=$a(dni) order by \
                            deuda desc" db]
            #coloreo tbl mismadireccion
        lmap row [.tdni2 searchcolumn 0 0 -not -numeric -all] {.tdni2 rowconfigure \
                  $row -bg red -fg white} ;#resalto si es deudor
        lmap row [.tdni2 searchcolumn 6 "-*" -glob -all] {.tdni2 rowconfigure \
                  $row -bg red -fg white} ;#resalto si es zona problema
        lmap row [.tdni2 searchcolumn 4 0 -numeric -all] {.tdni2 rowconfigure \
                  $row -bg SpringGreen2 -fg white} ;#resalto si no compro nada
        }
    } {;# si no existe cliente retorno erro
    return 0
    }
}
proc buscafem {dni} {
    global nombre regdni fdni
    #puts "busco femenino $dni"
    if {[string length $dni]==7} {set dni 0$dni}
    if {[fem exists {select dni,nombre from fem where dni match :dni}]} {
            fem eval {select dni,nombre from fem where dni match :dni} a {
                set regdni [lmap x $a(*) {list $x $a($x)}]
                .tdni1 configure -stripebackground {}
                set nombre $a(nombre)
            }} {;# cuando no existe ni siquiera en el padron mando un mensaje
        balloon $fdni.buscardni "No existen FEMENINOS con $dni"
        set nombre "No encontrado"
        }
}


proc buscamas {dni} {
    global nombre regdni fdni
    #puts "busco masculino $dni"
    if {[string first "-" $dni]==0} {set dni [string range $dni 1 end]}
    if {[mas exists {select dni,nombre from padron where dni match :dni}]} {
            mas eval {select dni,nombre from padron where dni match :dni} a {
                set regdni [lmap x $a(*) {list $x $a($x)}]
                .tdni1 configure -stripebackground {}
                set nombre $a(nombre)
            }} {;# cuando no existe ni siquiera en el padron mando un mensaje
        balloon $fdni.buscardni "No existen MASCULINOS con $dni"
        set nombre "No encontrado"
        }
}



pack $fdni.buscardni -fill x -in $fdni.fr -side left
pack $fdni.take -in $fdni.fr -side left

focus $fdni.buscardni

tbls .tdni1  $fdni  -height 18 -columns {6 campo 14 dato} -listvariable regdni\
            -takefocus 0 -stripebackground {} -showlabels 0
.tdni1 columnconfigure 1 -wrap 1
tbls .tdni2  $fdni  -height 10 -columns {0 deuda 0 nombre 0 dni 0 ultpago 0 comprado 0 ultcompra 0 zona 0 comentarios 0 tel 0 acla 0 id} -listvariable casadni -takefocus 0


#bind de ambos tbls para mostrar la ficha de venta
bind [.tdni1 bodytag] <Double-1> {if {[.tdni1 size]>2} {
                                 set id [.tdni1 getcell 15,1] ;# OJO el id es "fila"15
                                 muestraventa $id
}
}
bind [.tdni2 bodytag] <Double-1> {set id [.tdni2 getcell active,10];#OJO id es "col"10
                                  muestraventa $id
}

#
#PESTAÑA MUESTRAVENTA
#=================================================================
tbls .tvta1 $fvta  -height 5 -columns {
    0 fecha 0 saldo 0 art 0 cc 0 ic 0 ent 0 idvdor 0 id}\
-listvariable listaventas -font {Helvetica 9}
.tvta1 columnconfigure 1 -formatcommand cur -align right

tbls .tvta2 $fvta  -height 6 -columns {
    0 fecha 0 imp 0 rec 0 idvta 0 rbo 0 cobr} -listvariable listapagos -font {Helvetica 9}


tbls .tvta3 $fvta   -height 6 -columns {
    4 key 0 value} -listvariable vtadatos -showlabels 0 -stripebg {} -font {Helvetica 9}
.tvta3 columnconfigure 1 -wrap 1 -bg {light yellow} -fg black




proc muestraventa {id} {
   .n raise vta
   .tvta1 delete 0 end
    db eval {select nombre,comentarios,* from clientes where id=:id} a {
       balloon .tvta1 $a(infoseven) 20000
       set ::vtadatos [lmap x $a(*) {list $x $a($x)}]
   }
   set ::listaventas [tabule "select fecha,saldo,art,cc,ic,ent,idvdor,id from ventas
                           where idcliente=$id order by id desc" db]
   lmap row [.tvta1 searchcolumn 1 0.0 -not -all -numeric] {
       .tvta1 rowconfigure $row -bg red -fg white
   }
   set ::listapagos [tabule "select fecha,imp,rec,idvta,rbo,cobr from pagos
                           where idcliente=$id order by id desc" db]

}

#
#PESTAÑA CUADRA
#=================================================================
#reg eval "drop table if exists cuadras"
#reg eval "create table if not exists cuadras(id integer primary key, calle text)"
#reg eval "insert into cuadras(calle) values ('Villegas')"
#reg eval "alter table cuadras add column fecha"
#reg eval "insert into cuadras(calle) values ('Alarcon')"

#reg eval "create table if not exists planos(id integer primary key, plano text)"
set calles [db eval "select calle from calles where calle!='*' order by calle"]
pack [frame $fcua.f] -fill x
ComboBox .calle -width 12 -textvariable calle -values $calles \
-autocomplete 1  -entrybg bisque -fg black
#set ultcalle [reg onecolumn "select calle from cuadras order by id desc limit 1"]
set ultcalle "Wilson"
bind .calle.e <FocusIn> {.calle select range 0 end}
.calle setvalue @[lsearch $calles $ultcalle]
.calle.a configure -width 40
button .todos  -command {if {$calle != ""} {
                                       .tcua delete 0 end
                                       set clicuadra [tabule "select cast(num as int) as num,deuda,nombre,
                                       dni,calle,acla,id,
                                       case when
                                       julianday('now')-julianday(pmovto)>40 and
                                       deuda>0 and comprado>0 then 1
                                       when julianday('now')-julianday(pmovto)<=40
                                       and deuda>0 and comprado>0 then 0
                                       when comprado=0 then 3
                                       when deuda=0 then 2 end
                                       as atraso,barrio,zona
                                       from clientes where calle ='$calle'  order by num" db]
                                       lmap row [.tcua searchcolumn 7 1 -all -numeric] {
                                            .tcua rowconfigure $row -fg red
                                        }
                                       lmap row [.tcua searchcolumn 7 0 -all -numeric] {
                                            .tcua rowconfigure $row -fg blue
                                        }
                                       lmap row [.tcua searchcolumn 7 3 -all -numeric] {
                                            .tcua rowconfigure $row -fg {green}
                                        }
                                       lmap row [.tcua searchcolumn 9 "-*" -all -glob] {
                                            .tcua rowconfigure $row -font \
                                                     {Helvetica 9 bold} -fg {deep pink}
                                       }
                                       }
                                       } -text Todos
#Ojo aca el orden del case when es importante pq funciona como un switch o sea si una
#condicion anterior se cumple sale del bucle, o bien escribirlas todas excluyentes o
#bien cuidar el orden.
#si pongo deuda=0 primero marca 2 y sale... no me testea el siguiente comprado=0
#salvo que pusiera deuda=0 and comprado>0 marca 2 y pasa a comprado=0 y me marca 3
button .deudores  -command {if {$calle != ""} {
                                       .tcua delete 0 end
                                       set clicuadra [tabule "select cast(num as int) as num,deuda,nombre,
                                       dni,calle,acla,id,
                                       case when
                                       ultcompra>'2015-01-31' then 1
                                       when ultcompra<'2015-02-01' then 0
                                        end
                                       as atraso,barrio,zona
                                       from clientes where calle ='$calle' and deuda>0 order by num" db]
                                       lmap row [.tcua searchcolumn 7 1 -all -numeric] {
                                            .tcua rowconfigure $row -fg red
                                        }
                                       lmap row [.tcua searchcolumn 7 0 -all -numeric] {
                                            .tcua rowconfigure $row -fg blue
                                        }
                                        }
                                        } -text Deuda

.calle bind <Return> {cuadra}

#Ex-button C que muestra todos dentro de la cuadra que estamos
#AHORA button List que muestra los clientes a visitar en la calle.
#Modificaciones pedidas por el vendedor
# baje a 180 dias para que salgan menos
# tengo que evitar sacar si en la misma direccion son deudores.
button .cuadra  -command {set num [.tcua getcell active,0]
                                        set clicuadra [tabule "select cast(num as int) as num,comprado,\
                                         nombre,ultpago,dni,calle,id,
                                         barrio,zona
                                         from clientes where calle ='$calle'\
                                         and deuda=0 and comprado>0 and \
                                         ultpago>date('now','-240 days') \
                                         and zona NOT LIKE '-%' \
                                         and calle||num not in (select calle||num from clientes where deuda>0)
                                         order by num" db]
                                         } -text List



proc cuadra {} {.tcua delete 0 end
global calle clicuadra
                            set clicuadra [tabule "select cast(num as int) as num,deuda,nombre,dni,calle,
                            acla,id,
                            case when julianday('now')-julianday(pmovto)>40
                            and deuda>0 then 1
                            when deuda=0 then 2 else 0 end
                            as atraso,barrio,zona
                            from clientes where calle ='$calle' and deuda>0
                            order by num" db]
                            sdltk textinput 0
                            focus .tcua
                            lmap row [.tcua searchcolumn 7 1 -all -numeric] {
                                .tcua rowconfigure $row -fg red
                            }
                            lmap row [.tcua searchcolumn 7 0 -all -numeric] {
                                .tcua rowconfigure $row -fg blue
                            }
                            #if {[reg onecolumn "select calle from cuadras order by id desc limit 1"]!="$calle"} {
                            #reg eval "insert into cuadras(calle,fecha) values('$calle',datetime('now','localtime'))"
                            #}
}



.calle bind <FocusIn> ".calle.e selection range 0 end"
pack .calle  -fill x -in $fcua
pack [frame .cuaframe] -fill x -in $fcua
lower .cuaframe
pack .todos .deudores .cuadra -fill x -side left -in .cuaframe
tbls .tcua $fcua  -width 20 -height 4 -listvariable clicuadra -columns {4 num 0 deuda 0 cliente 0 dni 0 calle 0 acla 0 id 0 atraso 0 barrio 0 zona} -bg {bisque2} -stripebg {bisque} -fg black
.tcua columnconfigure 1 -formatcommand cur
.tcua columnconfigure 0 -sortmode integer -align right
bind [.tcua bodytag] <Double-1> {set id [.tcua getcell active,6]
                                 muestraventa $id
}

set i 1
array set color [list 1 SlateBlue1 2 SeaGreen2 3 aquamarine 4 beige 5 {light yellow}]
#bind [.tcua bodytag] <3> {set num [.tcua getcell active,0]
                         #if {[llength [.tcua searchcolumn 0 $num -all -numeric]]>1} {
                         #lmap row [.tcua searchcolumn 0 $num -all -numeric] {
                             #.tcua rowconfigure $row -bg $color($i)
                          #}
                          #incr i
                          #if {$i>5} {set i 1}
                         #}
#}

#cuadra ;#llamo proc cuadra para que llene la ultima buscada
#
#PESTAÑA REGISTRO
#=================================================================
##frame freg

#tbls .treg $freg  -listvariable regbuscados -columns {8 dni 0 nombre 0 fecha 0 id} -font {Helvetica 9}
#tbls .tregcuadras $freg -listvariable regcuadras -columns {8 calle 0 fecha 0 id} -font {Helvetica 8}
#pack [frame $freg.buttons] -fill x
#button $freg.busc -text {Buscados} -anchor center -command {set regbuscados [tabule "select dni, nombre, fecha, id from buscados order by id desc" reg]}
##pack $freg.busc -fill x -in $freg.buttons -side left
#button $freg.call -text {Calles} -anchor center -command {set regcuadras [tabule "select calle,fecha,id from cuadras order by id desc" reg]}
#pack $freg.call -fill x -in $freg.buttons -side left

#bind [.treg bodytag] <3> {set dni [.treg getcell active,0]
                          #if {[db exists "select id from clientes where dni=:dni"]} {
                              #set id [db onecolumn "select id from clientes
                                                    #where dni=:dni"]
                              #muestraventa $id
                          #} {
                              #balloon .treg "No es cliente de Romitex"
                          #}
#}
#bind [.treg bodytag] <Double-1> {set id [.treg getcell active,3]
                                #set delete [tk_messageBox -type "yesno" -message "Confirma\
                                #borrar el registro?" -icon question]
                                #if {$delete=="yes"} {
                                       #reg eval  "delete from buscados where id=$id"
                                       #set regbuscados [tabule "select dni,
                                          #nombre,fecha,id
                                          #from buscados
                                          #order by id desc limit 100" reg]
#
#}
#}
#bind [.tregcuadras bodytag] <Double-1> {set id [.tregcuadras getcell active,2]
                                #set delete [tk_messageBox -type "yesno" -message "Confirma\
                                #borrar el registro?" -icon question]
                                #if {$delete=="yes"} {
                                       #reg eval  "delete from cuadras where id=$id"
                                       #set regcuadras [tabule "select calle,fecha,id
                                          #from cuadras
                                          #order by id desc" reg]
#}
#}
#proc llenaregistros {} {
#global regbuscados regcuadras
#
#set regbuscados [tabule "select dni,nombre,fecha,id from buscados order by id desc limit 100" reg]
#lmap row [.treg searchcolumn 2 "[hoy]*" -all -glob] {.treg rowconfigure $row -foreground orange}
#set regcuadras [tabule "select calle,fecha,id from cuadras order by id desc" reg]
#lmap row [.tregcuadras searchcolumn 1 "[hoy]*" -all -glob] {.tregcuadras rowconfigure $row -background yellow -foreground blue}
#}
##Luego se podria hacer algunas otras cositas con los registros segun demanda p.e.
##marcar los buscados que compraron
#
#----------------------------------------------------------------
#PESTAÑA PLANOS -- EXPERIMENTAL
#-----------------------------------------------------------------
#1)defino un directorio de planos en donde guardo las imagenes en formato jpg
#no importaria cambiar por otras despues veo por peso y claridad.
#2)cuando la aplicacion funciona no se levanta nada o sea no hay pesos extras
#3) el combo obtiene sus valores de una lista de archivos por
#glob -directory $dir -tails (para darme solo las colas) con el glob patron
#4) luego esa lista la arreglo con lmap sacandole la desinencia con regsub
#regsub {(\w)(.jpg)} el patern es dos partes de la palabra y solo quiero la 1ra
#por eso la subspecie es {\1}
#5) por ultimo el combo al elegir el plano, lo crea con el conocido
#image create photo
#y lo monta en el text

#ComboBox $fpla.planos -textvariable plano \
#-values {YofreSur Ituizango} -autocomplete 1 -takefocus 0
  #  -values [lsort [lmap x [glob -directory $dir -tails *jpg] {
  #                        regsub {(\w)(.jpg)} $x {\1}}]] -autocomplete 1 \
  #                        -takefocus 0
#$fpla.planos.a configure -width 30
##focus $fpla.planos.e
#$fpla.planos bind <FocusIn> {
    #$fpla.planos.e selection range 0 end
    #sdltk textinput on 0 0 1
#}
#$fpla.planos bind <Return> {
        #levantarplano
        #reg eval "insert into planos(plano) values ('$plano')"
#
#}
#$fpla.planos configure -modifycmd {
        #levantarplano
        #reg eval "insert into planos(plano) values ('$plano')"
#
#}
#proc levantarplano {} {
    #global plano dir
    #puts $plano
    #if {$plano==""} {
    #set plano [reg onecolumn "select plano from planos order by id desc limit 1"]
#}
    #catch {
    #.plano configure -state normal
    #image create photo $plano -file [file join $dir $plano].jpg
    #.plano delete 1.0 end
    #.plano image create 1.0 -image $plano
    #.plano configure -state disabled
    #sdltk textinput 0} error
    #puts $error
#}

#pack $fpla.planos -fill x
#set scv [scrollbar .scv -width 40 -orient vertical \
                 #-command ".plano yview" -bg grey17]
#set sch [scrollbar .sch -width 40 -orient horizontal \
                 #-command ".plano xview" -bg grey17]
#text .plano -bg cyan -width 100 -height 16 -xscrollcommand [list $sch set] \
      #-yscrollcommand [list $scv set]
#
#pack $scv -fill y -side right -in $fpla
#pack .plano -fill both -expand yes -in $fpla
#pack $sch -fill x -side bottom -in $fpla
#

#levantarplano
#-----------------------------------------------------------------------------------
#pestaña telefonos - buscador exclusivo para telefono y busqueda nombre y calle y num
#----------------------------------------------------------------------------------
#sector calle y num
pack [frame $ftel.callenum] -fill x

entry $ftel.calle -textvariable callebuscar -bg bisque -fg black -width 10
pack $ftel.calle -side left -in $ftel.callenum

entry $ftel.num -textvariable numbuscar -bg bisque -fg black -width 5
pack $ftel.num -side left -in $ftel.callenum

tbls .tcallenum $ftel -listvariable callenum -columns {0 nombre 0 saldo 0 dni \
    0 id 0 calle 0 num} -width 20 -height 4
.tcallenum columnconfigure 1 -formatcommand cur

bind $ftel.num <FocusIn> {sdltk textinput on 0 0 0}
bind $ftel.calle <Return> "focus $ftel.num"
bind $ftel.num <Return> {
    regsub -- {-} $numbuscar "%%" numbuscar
    regsub -- {\.} $numbuscar "%%" numbuscar
    set callenum [tabule "select nombre,deuda, dni,id,calle,num \
    from clientes where calle like '%%$callebuscar%%'\
     and num like '$numbuscar'" db]

lmap row [.tcallenum searchcolumn 1 0 -not -all -numeric]\
 {.tcallenum rowconfigure $row -background red -foreground white}
sdltk textinput off
if {[llength $callenum]==0} {balloon .tcallenum "No hay resultados"}
}
bind [.tcallenum bodytag] <Double-1> {set id [.tcallenum getcell active,3]
                                      muestraventa $id
}
#sector tel
entry $ftel.buscar -textvariable tel -bg bisque -fg black
bind $ftel.buscar <FocusIn> {sdltk textinput on 0 0 0}
bind $ftel.buscar <Return> {
set telefonos [tabule "select tel, nombre, id from clientes where tel like \
'%%$tel%%' order by tel limit 100" db]
sdltk textinput off
if {[llength $telefonos]==0} {balloon .ttel "No hay resultados"}
}

pack $ftel.buscar -fill x
tbls .ttel $ftel -listvariable telefonos -columns {0 tel 0 nombre 0 id} \
 -width 20 -height 4

bind [.ttel bodytag] <Double-1> {set id [.ttel getcell active,2]
                                muestraventa $id
}


#PESTAÑA BUSCAR POR NOMBRE EN PADRONES
#
entry $fbus.buscar -textvariable buscargral -font {Helvetica 10 bold} -bg {light\
yellow} -fg blue
pack $fbus.buscar -fill x

bind $fbus.buscar <1> {%W selection range 0 end
                         sdltk textinput on 0 0 0
                         }
bind $fbus.buscar <FocusIn> {%W selection range 0 end
                                sdltk textinput on 0 0 0
                               }
bind $fbus.buscar <Return> {.tbuscargral delete 0 end

                            if {[db exists "select dni,nombre,id from goo1 \
                                           where goo1  match '$buscargral'"]} {
                                set buscargeneral [tabule "select dni,nombre,id\
                                from goo1 where goo1 match '$buscargral'" db]
                            } {;# if not exists en tabla clientes
                            if {[fem exists "select dni,nombre from fem\
                            where fem match '$buscargral'"]} {
                                set buscargeneral [tabule "select dni,nombre,'' \
                                from fem where fem match '$buscargral'" fem]
                            } {;# if not exist in padron FEMENINOS
                                if {[mas exists "select dni,nombre from padron\
                                where padron match '$buscargral'"]} {
                                  set buscargeneral [tabule "select dni,nombre,'' \
                                  from padron where padron match '$buscargral'"\
                                  mas]
                                } {;# if no exist en MASCULINOS tampoco
                                    balloon .tbuscargral "NO EXISTE"

                                }
                            }
                            }
                            lmap row [.tbuscargral searchcolumn 2 "" -not\
                            -all] {.tbuscargral rowconfigure $row \
                            -background cyan -fg navy}
                        }



tbls .tbuscargral $fbus -height 6 -width 20 -columns {0 dni 0 nombre 0 id} \
                        -listvariable buscargeneral
bind [.tbuscargral bodytag] <Double-1> {if {[.tbuscargral getcell \
  active,2]!=""} {muestraventa [.tbuscargral getcell active,2]} {
      balloon .tbuscargral "No es cliente de Romitex"}
  }

focus $fbus.buscar

tbls .tultvtas $fbus -height 6 -width 20 -columns {0 calle 0 num 0 nombre \
                                            0 ultcompra 0 id} \
                        -listvariable ultventas
set ultventas [tabule "select calle,num,nombre,ultcompra,id from clientes \
where ultcompra>date('now','-10 days') order by ultcompra desc" db]
bind [.tultvtas bodytag] <Double-1> {muestraventa [.tultvtas getcell active,4]}

#PESTAÑA BUSCAR POR FTS4 cualquier informacion
#
entry $fbus1.buscar1 -textvariable buscargral1 -font {Helvetica 10 bold} -bg {light\
yellow} -fg blue
pack $fbus1.buscar1 -fill x

bind $fbus1.buscar1 <1> {%W selection range 0 end
                         sdltk textinput on 0 0 0
                         }
bind $fbus1.buscar1 <FocusIn> {%W selection range 0 end
                                sdltk textinput on 0 0 0
                               }
bind $fbus1.buscar1 <Return> {.tbuscargral1 delete 0 end
                              set buscargeneral1 [tabule "select * from goo1 where \
                                  goo1 match '$buscargral1'"]
                            }
                            



tbls .tbuscargral1 $fbus1 -height 6 -width 20 -columns {0 id 0 nombre 0 dni 0  calle 0 num 0 barrio 0 acla 0 tel 0 deuda 0 ultpago 0 ultimacompra 0 comprado} \
                        -listvariable buscargeneral1
bind [.tbuscargral1 bodytag] <Double-1> {muestraventa [.tbuscargral1 getcell active,0]} 

focus $fbus1.buscar1

#
#DOCUMENTACION DEL TIPO DE CLASE USADO EN ESA APLICACION
#=================================================================
####ver la explicacion tecnica dentro de la class
#
#uso una clase con itcl para "empaquetar" un tablelist y dos scroll en forma simple
#y rapida (tengo casi 7) y seria muy engorroso tener que packearlos con sus respectivos
#scroll vertical y horizontal o sea ... 14 scrollbar!!!!!!
#
#pero no hago uso aca de itk.!!!! ojo
#por eso este archivo es autocontenido, no depende de ningun source.
#los proc que necesita los tiene incorporado pq son proc ya establecidos hace tiempo
#que no vale la pena tener separados
#y no son muchos
#tabule / balloon / cur / etc.

#el uso del tbls se hace muy directo:
#
#tbls .treg $frame -width .... etc como si estuviera trabajando con
#tablelist::tablelist .treg -width ...
#solo que tbls llama a un proc que a su vez llama a la class Tbls con un argumento
#posicional luego del nombre del objeto que indica el frame en donde voy a montar el
#tablelist.
#Ese frame viene usualmente del getframe del NoteBook.
#La bocha es que se puede usar toda la funcionalidad del tablelist como si estuviera
#montando en pelo, pero con los dos scrollbar gratis adosados sin preocuparme de ellos.
#El resto de los widget son usuales entry, button y ComboBox,NoteBook de BWidget
#

#TBLS LLENADO COMO SET DE ENTRYS
#=================================================================
            #set regdni [lmap x $a(*) {list $x $a($x)}]
#hago un tbls con listvariable
#luego desde un eval {select } a {
#lleno el list con lmap x $a(*) {list $x $a($x)}
            #o sea lmapeo la lista de nombres de columnas y lleno el acumulador de lmap
            #con sublistas de nombrecolumna - valor de la columna
######################################################################################

#con la no determinacion de width cuando el tbls va usar todo el ancho gracias a
#expand -yes puedo tenerla en la tablet igual
