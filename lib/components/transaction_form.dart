import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_routes.dart';


class TransactionForm extends StatefulWidget {

  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
    final _titleController = TextEditingController();
    final _valueController = TextEditingController();
    DateTime _selectedDate = DateTime.now(); 


  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null ) {
      return;
    }
    
    widget.onSubmit(title, value, _selectedDate); 
  }

  _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now(),
      ).then((pickedDate) {
      if(pickedDate == null){
        return; 
      } 

     setState(() {
        _selectedDate = pickedDate; 
     });
      }
      );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 7),
        child: Column(
          children: <Widget>[

           Text(                 
             'Cadastrar gasto da Viagem',
              style: Theme.of(context).textTheme.headline6,
           ),
           
           SizedBox(height: 7),

             TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Gasto',
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Novo gasto'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitForm,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
