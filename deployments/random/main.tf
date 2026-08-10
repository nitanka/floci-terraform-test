# resource local_file "testfile" {
#     count = length(var.fileIndex)

#     filename = "nitanka-${var.fileIndex[count.index]}.txt"
#     content = "THis is just a test"
# }

resource "local_file" "testfile" {
    for_each = toset(var.fileSuffix)
    filename = "nitanka-${each.value}"
    content = "this is ${each.value}"
}