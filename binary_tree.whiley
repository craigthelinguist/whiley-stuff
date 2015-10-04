

type Node is null | NodeData

type NodeData is {
    int content,
    Node left,
    Node right
}

type BinaryTree is {
    int size,
    Node root
}

/**
    Create and return an empty binary search tree.
**/

function BTree_make () -> (BinaryTree bt)
  ensures BTree_size(bt) == 0:
    return {
        size : 0,
        root : null
    }

/**
    Returns the number of things in the tree.
        bt : tree to check.
**/

function BTree_size (BinaryTree bt) -> (int r):
    return bt.size

/**
    Check if the tree contains a specified item.
        bt : tree to search.
        item : desired item.
**/

function Rec_contains (Node nd, int item) -> (bool b)
  ensures b <==> nd is NodeData && (nd.content == item
          || Rec_contains(nd.left, item) || Rec_contains(nd.right, item)):
    if nd is null:
        return false
    if nd.content == item:
        return true
    if Rec_contains(nd.left, item):
        return true
    if Rec_contains(nd.right, item):
        return true
    return false

function BTree_contains (BinaryTree bt, int item) -> (bool b)
  ensures b <==> bt.root is Node && Rec_contains(bt.root, item):
    if bt.root is null:
        return false
    else:
        return Rec_contains(bt.root, item)

/**
    Add an item to the tree.
        bt : tree to add the item to.
        item : item to add to the tree.
**/

function BTree_add (BinaryTree bt, int item) -> (BinaryTree bt2)
  ensures BTree_size(bt2) == BTree_size(bt) + 1
  ensures BTree_contains(bt2, item):
    BinaryTree bt2 = bt
    bt2.root = Rec_add (bt2.root, item)
    bt2.size = bt2.size + 1
    return bt2

function Rec_add (Node nd, int item) -> (Node nd2)
  ensures Rec_contains(nd2, item):

    // Base case: at the bottom of tree.
    Node nd2 = nd
    if nd2 is null:
        nd2 = {
            content : item,
            left : null,
            right : null
        }

    // Branch on value in node.
    else if item < nd2.content:
        nd2.left = Rec_add (nd2.left, item)
    else:
        nd2.right = Rec_add (nd2.right, item)
    return nd2
