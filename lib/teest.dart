import 'package:flutter/material.dart';

class AnimatedListWidget extends StatefulWidget {
  @override
  _AnimatedListWidgetState createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  // the GlobalKey is needed to animate the list
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final GlobalKey<AnimatedListState> _listKey1 = GlobalKey();

  // backing data
  // List<String> _data = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  // ];
  Map<int, GlobalKey<FormState>> keymap = new Map<int, GlobalKey<FormState>>();
  Map<int, GlobalKey<FormState>> keymap1 = new Map<int, GlobalKey<FormState>>();
  int itemno = 4;
  List<int> sol=[0,1,2,3];
  Map<int, String> map = new Map<int, String>();
  Map<int, String> map1 = new Map<int, String>();

  int solindx=4;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: _listKey,
            initialItemCount: sol.length,
            itemBuilder: (context, index, animation) {
              if (keymap[sol.elementAt(index)] == null) {
                keymap[index] = new GlobalKey<FormState>();
              }
              return Column(
                children: [
                  Form(
                    key: keymap[sol.elementAt(index)],
                    child: _buildItem( animation, sol.elementAt(index)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // SizedBox(
                  //   height: 10,
                  //   child: ListView.builder(
                  //     itemCount: 3,
                  //     itemBuilder: (context, index1) {
                  //       if (keymap1[(sol.elementAt(index))*3] == null) {
                  //         keymap1[(sol.elementAt(index))*3] = new GlobalKey<FormState>();
                  //         keymap1[((sol.elementAt(index))*3)+1] = new GlobalKey<FormState>();
                  //         keymap1[((sol.elementAt(index))*3)+2] = new GlobalKey<FormState>();
                  //       }
                  //       return Column(
                  //         children: [
                  //           Form(
                  //             autovalidateMode: AutovalidateMode.always,
                  //             key: keymap1[((sol.elementAt(index))*3)+index1],
                  //             child: _buildItem1(((sol.elementAt(index))*3)+index1),
                  //           ),
                  //           SizedBox(
                  //             height: 15,
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ),
        FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () => _insertSingleItem(),
        ),
      ],
    );
  }

  Widget _buildItem(Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: TextFormField(
          initialValue: map[index],
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.lightGreen,
                  width: 2,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.deepPurple,
                  width: 2,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.pink,
                  width: 2,
                )),
            contentPadding: EdgeInsets.all(15),
            labelText: "أدخل السؤال",
            labelStyle: TextStyle(fontSize: 20),
            prefixIcon: Icon(Icons.question_answer_outlined),
            suffixIcon: IconButton(
              icon: Icon(Icons.delete_outlined),
              onPressed: () {
                _removeSingleItems(index);
              },
            ),
            hintText: "السؤال",
          ),
          validator: (valu) {
            if (valu.isEmpty) {
              return "هذا الحقل مطلوب";
            } else if (valu.length < 5) {
              return "الكلمة قصيرة جدا";
            } else
              return null;
          },
          keyboardType: TextInputType.text,
          onChanged: (v) {
            setState(() {
              map[index] = v;
            });
          },
          onSaved: (valu) {
            map[index] = valu;
          },
        ),
      ),
    );
  }

  Widget _buildItem1(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: TextFormField(
        initialValue: map1[index],
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.lightGreen,
                width: 1,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.deepPurple,
                width: 1,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.pink,
                width: 1,
              )),
          contentPadding: EdgeInsets.all(15),
          labelText: "أدخل الجواب",
          labelStyle: TextStyle(fontSize: 20),
          prefixIcon: Icon(Icons.workspaces_outline),
          // suffixIcon: IconButton(
          //   icon: Icon(Icons.delete_outlined),
          //   onPressed: () {
          //     _removeSingleItems(index);
          //   },
          // ),
          hintText: "الجواب",
        ),
        validator: (valu) {
          if (valu.isEmpty) {
            return "هذا الحقل مطلوب";
          } else if (valu.length < 5) {
            return "الكلمة قصيرة جدا";
          } else
            return null;
        },
        keyboardType: TextInputType.text,
        onChanged: (v) {
          setState(() {
            map1[index] = v;
          });
        },
        onSaved: (valu) {
          map1[index] = valu;
        },
      ),
    );
  }

  /// Method to add an item to an index in a list
  void _insertSingleItem() {
    int insertIndex;
    if (sol.length > 0) {
      insertIndex = sol.length;
    } else {
      insertIndex = 0;
    }
    //String item = "Item ${itemno = itemno + 1}";
    //_data.insert(insertIndex, item);
    _listKey.currentState.insertItem(insertIndex);
    sol.add(solindx);
    solindx++;
  }

  /// Method to remove an item at an index from the list
  void _removeSingleItems(int removeAt) {
    int removeIndex = removeAt;
    if (map[removeIndex]!=null){ map.remove(removeIndex);keymap.remove(removeIndex);}
    // if (map1[removeIndex * 3]!=null) {map1.remove(removeIndex * 3);keymap1.remove(removeIndex * 3);}
    // if (map1[(removeIndex * 3) + 1]!=null){
    //   map1.remove((removeIndex * 3) + 1);
    //   keymap1.remove((removeIndex * 3) + 1);}
    // if (map1[(removeIndex * 3) + 2]!=null){
    //   map1.remove((removeIndex * 3) + 2);
    //   keymap1.remove((removeIndex * 3) + 2);}

    sol.removeAt(removeIndex);
    //String removedItem = _data.removeAt(removeIndex);
    // This builder is just so that the animation has something
    // to work with before it disappears from view since the original
    // has already been deleted.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      // A method to build the Card widget.
      return Text("kii");
    };
    _listKey.currentState.removeItem(removeIndex, builder);
    print(map.values);
    print("\n\n\n");
    // print(map1.values);
  }
}
