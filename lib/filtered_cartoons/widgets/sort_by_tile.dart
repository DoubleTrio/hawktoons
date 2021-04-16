import 'package:flutter/material.dart';

class SortByTile extends StatelessWidget {
  SortByTile(
      {Key? key,
      required this.selected,
      required this.onTap,
      required this.header})
      : super(key: key);

  final bool selected;
  final VoidCallback onTap;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        header,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: selected ? Colors.orange : Colors.black38),
                      ),
                      if (selected)
                        const Icon(
                          Icons.check,
                          color: Colors.orange,
                          size: 18,
                        ),
                    ],
                  ),
                )),
          ),
          const Divider(
            color: Colors.black12,
            thickness: 1,
            height: 1,
          ),
        ],
      ),
    );
  }
}
