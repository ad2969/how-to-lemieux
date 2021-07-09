#define PIXEL_NUM 200

#include <stdlib.h>
#include <stdio.h>
#include "vga_plot.h"

void main() {
  char pixelArray[] = {83, 1, 84, 1, 85, 1, 86, 1, 87, 1, 88, 1, 89, 1, 90, 1, 91, 1, 92, 1, 66, 2, 67, 2, 68, 2, 69, 2, 70, 2, 71, 2, 72, 2, 73, 2, 74, 2, 75, 2, 76, 2, 77, 2, 80, 2, 81, 2, 82, 2, 83, 2, 93, 2, 94, 2, 95, 2, 61, 3, 62, 3, 63, 3, 64, 3, 75, 3, 76, 3, 77, 3, 78, 3, 79, 3, 80, 3, 96, 3, 97, 3, 71, 4, 72, 4, 73, 4, 74, 4, 75, 4, 76, 4, 98, 4, 99, 4, 59, 5, 68, 5, 69, 5, 70, 5, 71, 5, 100, 5, 101, 5, 58, 6, 59, 6, 66, 6, 67, 6, 68, 6, 102, 6, 103, 6, 57, 7, 59, 7, 64, 7, 65, 7, 103, 7, 104, 7, 116, 7, 117, 7, 118, 7, 119, 7, 120, 7, 121, 7, 122, 7, 123, 7, 56, 8, 57, 8, 59, 8, 62, 8, 63, 8, 105, 8, 113, 8, 114, 8, 115, 8, 116, 8, 117, 8, 118, 8, 119, 8, 120, 8, 121, 8, 122, 8, 123, 8, 124, 8, 125, 8, 126, 8, 127, 8, 56, 9, 60, 9, 61, 9, 62, 9, 111, 9, 112, 9, 113, 9, 123, 9, 124, 9, 127, 9, 128, 9, 129, 9, 130, 9, 131, 9, 55, 10, 58, 10, 59, 10, 60, 10, 110, 10, 111, 10, 114, 10, 124, 10, 125, 10, 131, 10, 132, 10, 133, 10, 134, 10, 135, 10, 136, 10, 55, 11, 57, 11, 58, 11, 109, 11, 114, 11, 116, 11, 125, 11, 126, 11, 135, 11, 136, 11, 137, 11, 138, 11, 139, 11, 54, 12, 56, 12, 57, 12, 108, 12, 112, 12, 113, 12, 115, 12, 116, 12, 118, 12, 126, 12, 139, 12, 140, 12, 141, 12, 142, 12, 54, 13, 55, 13, 56, 13, 107, 13, 111, 13, 113, 13, 115, 13, 118, 13, 121, 13, 126, 13, 142, 13, 143, 13, 144, 13, 145, 13, 53, 14, 54, 14, 55, 14, 107, 14, 111, 14, 112, 14, 115, 14, 117, 14, 120, 14, 123, 14, 126, 14, 127, 14, 145, 14, 146, 14, 147, 14, 148, 14, 53, 15, 54, 15, 110, 15, 112, 15, 114, 15, 117, 15, 120, 15, 122, 15, 123, 15, 125, 15, 127, 15, 148, 15, 149, 15, 150, 15, 52, 16, 53, 16, 110, 16, 111, 16, 112, 16, 114, 16, 116, 16, 119, 16, 122, 16, 124, 16, 125, 16, 127, 16, 150, 16, 151, 16, 152, 16, 51, 17, 52, 17, 109, 17, 111, 17, 113, 17, 116, 17, 119, 17, 121, 17, 124, 17, 127, 17, 128, 17, 153, 17, 154, 17, 50, 18, 51, 18, 59, 18, 109, 18, 110, 18, 112, 18, 113, 18, 115, 18, 118, 18, 121, 18, 123, 18, 128, 18, 155, 18, 156, 18, 49, 19, 50, 19, 59, 19, 108, 19, 110, 19, 112, 19, 115, 19, 118, 19, 120, 19, 123, 19, 128, 19, 155, 19, 156, 19, 48, 20, 49, 20, 57, 20, 58, 20, 109, 20, 112, 20, 114, 20, 117, 20, 120, 20, 122, 20, 128, 20, 48, 21, 58, 21, 111, 21, 114, 21, 117, 21, 119, 21, 122, 21, 124, 21, 128, 21, 47, 22, 56, 22, 110, 22, 111, 22, 113, 22, 116, 22, 119, 22, 121, 22, 124, 22, 128, 22, 129, 22, 46, 23, 54, 23, 56, 23, 57, 23, 110, 23, 113, 23, 116, 23, 118, 23, 120, 23, 121, 23, 123, 23, 128, 23, 129, 23, 45, 24, 52, 24, 54, 24, 55, 24, 57, 24, 109, 24, 110, 24, 112, 24, 115, 24, 117, 24, 118, 24, 120, 24, 122, 24, 123, 24, 126, 24, 128, 24, 129, 24, 44, 25, 45, 25, 52, 25, 112, 25, 115, 25, 117, 25, 119, 25, 122, 25, 125, 25, 128, 25, 129, 25, 43, 26, 44, 26, 52, 26, 53, 26, 56, 26, 111, 26, 114, 26, 116, 26, 119, 26, 121, 26, 124, 26, 129, 26, 42, 27, 43, 27, 111, 27, 114, 27, 116, 27, 118, 27, 121, 27, 124, 27, 129, 27, 41, 28, 42, 28, 113, 28, 115, 28, 118, 28, 120, 28, 123, 28, 129, 28, 40, 29, 41, 29, 113, 29, 115, 29, 117, 29, 120, 29, 123, 29, 125, 29, 126, 29, 129, 29, 130, 29, 39, 30, 40, 30, 112, 30, 114, 30, 116, 30, 117, 30, 119, 30, 122, 30, 125, 30, 130, 30, 39, 31, 112, 31, 114, 31, 116, 31, 119, 31, 122, 31, 124, 31, 130, 31, 131, 31, 38, 32, 39, 32, 54, 32, 113, 32, 115, 32, 118, 32, 121, 32, 124, 32, 126, 32, 131, 32, 37, 33, 38, 33, 53, 33, 113, 33, 115, 33, 118, 33, 121, 33, 123, 33, 126, 33, 131, 33, 36, 34, 37, 34, 52, 34, 53, 34, 112, 34, 114, 34, 117, 34, 120, 34, 123, 34, 125, 34, 132, 34, 35, 35, 36, 35, 114, 35, 117, 35, 120, 35, 122, 35, 125, 35, 127, 35, 132, 35, 51, 36, 113, 36, 116, 36, 117, 36, 119, 36, 121, 36, 122, 36, 124, 36, 127, 36, 132, 36, 133, 36, 36, 37, 112, 37, 113, 37, 116, 37, 118, 37, 119, 37, 121, 37, 124, 37, 127, 37, 133, 37, 36, 38, 50, 38, 112, 38, 115, 38, 116, 38, 118, 38, 120, 38, 123, 38, 126, 38, 127, 38, 128, 38, 133, 38, 134, 38, 50, 39, 95, 39, 98, 39, 111, 39, 114, 39, 115, 39, 117, 39, 120, 39, 123, 39, 125, 39, 127, 39, 128, 39, 134, 39, 36, 40, 37, 40, 94, 40, 95, 40, 98, 40, 99, 40, 111, 40, 114, 40, 116, 40, 117, 40, 119, 40, 122, 40, 125, 40, 126, 40, 127, 40, 129, 40, 134, 40, 35, 41, 36, 41, 37, 41, 44, 41, 95, 41, 96, 41, 97, 41, 99, 41, 100, 41, 110, 41, 114, 41, 116, 41, 118, 41, 119, 41, 122, 41, 124, 41, 127, 41, 128, 41, 134, 41, 33, 42, 34, 42, 35, 42, 36, 42, 37, 42, 38, 42, 44, 42, 57, 42, 93, 42, 94, 42, 96, 42, 98, 42, 99, 42, 113, 42, 115, 42, 116, 42, 117, 42, 118, 42, 121, 42, 124, 42, 126, 42, 128, 42, 134, 42, 135, 42, 36, 43, 37, 43, 38, 43, 43, 43, 44, 43, 48, 43, 56, 43, 57, 43, 95, 43, 96, 43, 99, 43, 100, 43, 101, 43, 113, 43, 115, 43, 117, 43, 121, 43, 123, 43, 126, 43, 127, 43, 134, 43, 135, 43, 38, 44, 43, 44, 47, 44, 55, 44, 56, 44, 57, 44, 58, 44, 90, 44, 91, 44, 92, 44, 94, 44, 96, 44, 100, 44, 101, 44, 114, 44, 115, 44, 116, 44, 117, 44, 120, 44, 122, 44, 123, 44, 125, 44, 127, 44, 129, 44, 134, 44, 135, 44, 38, 45, 42, 45, 43, 45, 47, 45, 54, 45, 55, 45, 56, 45, 57, 45, 91, 45, 93, 45, 94, 45, 95, 45, 96, 45, 97, 45, 98, 45, 100, 45, 101, 45, 102, 45, 113, 45, 114, 45, 116, 45, 119, 45, 120, 45, 122, 45, 125, 45, 127, 45, 129, 45, 134, 45, 135, 45, 38, 46, 42, 46, 46, 46, 55, 46, 56, 46, 60, 46, 61, 46, 62, 46, 63, 46, 64, 46, 65, 46, 66, 46, 67, 46, 68, 46, 69, 46, 70, 46, 71, 46, 72, 46, 73, 46, 91, 46, 92, 46, 94, 46, 97, 46, 99, 46, 101, 46, 113, 46, 115, 46, 116, 46, 119, 46, 121, 46, 124, 46, 126, 46, 129, 46, 135, 46, 38, 47, 41, 47, 42, 47, 58, 47, 59, 47, 60, 47, 62, 47, 63, 47, 64, 47, 65, 47, 66, 47, 67, 47, 68, 47, 69, 47, 70, 47, 71, 47, 72, 47, 73, 47, 74, 47, 75, 47, 89, 47, 91, 47, 92, 47, 93, 47, 96, 47, 97, 47, 98, 47, 100, 47, 113, 47, 115, 47, 118, 47, 120, 47, 121, 47, 124, 47, 126, 47, 128, 47, 135, 47, 38, 48, 41, 48, 45, 48, 52, 48, 57, 48, 58, 48, 59, 48, 62, 48, 64, 48, 65, 48, 66, 48, 67, 48, 68, 48, 69, 48, 70, 48, 71, 48, 72, 48, 73, 48, 74, 48, 75, 48, 89, 48, 90, 48, 92, 48, 94, 48, 95, 48, 97, 48, 98, 48, 100, 48, 101, 48, 118, 48, 120, 48, 123, 48, 125, 48, 128, 48, 135, 48, 38, 49, 40, 49, 41, 49, 44, 49, 52, 49, 56, 49, 57, 49, 58, 49, 60, 49, 61, 49, 62, 49, 64, 49, 65, 49, 66, 49, 67, 49, 68, 49, 69, 49, 70, 49, 72, 49, 73, 49, 74, 49, 75, 49, 76, 49, 88, 49, 89, 49, 91, 49, 92, 49, 96, 49, 98, 49, 99, 49, 117, 49, 119, 49, 120, 49, 123, 49, 125, 49, 127, 49, 131, 49, 135, 49, 37, 50, 38, 50, 40, 50, 52, 50, 55, 50, 56, 50, 57, 50, 58, 50, 59, 50, 60, 50, 61, 50, 62, 50, 63, 50, 65, 50, 66, 50, 67, 50, 68, 50, 69, 50, 70, 50, 71, 50, 73, 50, 74, 50, 88, 50, 90, 50, 91, 50, 93, 50, 94, 50, 95, 50, 97, 50, 99, 50, 100, 50, 119, 50, 122, 50, 125, 50, 127, 50, 130, 50, 135, 50, 156, 50, 37, 51, 39, 51, 40, 51, 43, 51, 55, 51, 56, 51, 57, 51, 58, 51, 60, 51, 61, 51, 63, 51, 64, 51, 72, 51, 73, 51, 90, 51, 92, 51, 94, 51, 95, 51, 96, 51, 118, 51, 121, 51, 122, 51, 124, 51, 127, 51, 130, 51, 135, 51, 154, 51, 155, 51, 156, 51, 37, 52, 38, 52, 39, 52, 42, 52, 51, 52, 52, 52, 54, 52, 55, 52, 58, 52, 59, 52, 61, 52, 62, 52, 64, 52, 65, 52, 66, 52, 67, 52, 68, 52, 69, 52, 70, 52, 71, 52, 72, 52, 87, 52, 89, 52, 91, 52, 93, 52, 95, 52, 96, 52, 97, 52, 98, 52, 99, 52, 118, 52, 121, 52, 124, 52, 126, 52, 130, 52, 135, 52, 152, 52, 153, 52, 154, 52, 37, 53, 38, 53, 54, 53, 56, 53, 57, 53, 59, 53, 60, 53, 61, 53, 65, 53, 67, 53, 68, 53, 69, 53, 92, 53, 93, 53, 94, 53, 96, 53, 97, 53, 98, 53, 99, 53, 126, 53, 129, 53, 135, 53, 136, 53, 151, 53, 152, 53, 37, 54, 41, 54, 53, 54, 54, 54, 55, 54, 58, 54, 59, 54, 60, 54, 61, 54, 63, 54, 64, 54, 65, 54, 67, 54, 69, 54, 95, 54, 97, 54, 99, 54, 100, 54, 125, 54, 129, 54, 131, 54, 135, 54, 136, 54, 150, 54, 151, 54, 36, 55, 37, 55, 52, 55, 53, 55, 55, 55, 56, 55, 57, 55, 59, 55, 60, 55, 62, 55, 63, 55, 64, 55, 97, 55, 98, 55, 99, 55, 128, 55, 131, 55, 135, 55, 136, 55, 149, 55, 150, 55, 35, 56, 36, 56, 54, 56, 55, 56, 57, 56, 58, 56, 59, 56, 61, 56, 63, 56, 100, 56, 128, 56, 131, 56, 136, 56, 149, 56, 35, 57, 39, 57, 57, 57, 59, 57, 61, 57, 127, 57, 128, 57, 130, 57, 136, 57, 148, 57, 149, 57, 34, 58, 35, 58, 130, 58, 132, 58, 136, 58, 148, 58, 33, 59, 34, 59, 38, 59, 130, 59, 132, 59, 136, 59, 147, 59, 148, 59, 32, 60, 33, 60, 37, 60, 129, 60, 130, 60, 132, 60, 136, 60, 147, 60, 31, 61, 32, 61, 37, 61, 129, 61, 131, 61, 136, 61, 147, 61, 31, 62, 36, 62, 131, 62, 132, 62, 136, 62, 146, 62, 147, 62, 30, 63, 130, 63, 131, 63, 132, 63, 136, 63, 146, 63, 29, 64, 30, 64, 35, 64, 132, 64, 136, 64, 146, 64, 28, 65, 29, 65, 34, 65, 131, 65, 136, 65, 145, 65, 146, 65, 27, 66, 28, 66, 33, 66, 131, 66, 136, 66, 137, 66, 145, 66, 26, 67, 27, 67, 32, 67, 136, 67, 137, 67, 144, 67, 145, 67, 25, 68, 26, 68, 31, 68, 137, 68, 144, 68, 24, 69, 25, 69, 30, 69, 137, 69, 143, 69, 144, 69, 23, 70, 24, 70, 29, 70, 137, 70, 143, 70, 23, 71, 137, 71, 142, 71, 143, 71, 22, 72, 137, 72, 142, 72, 21, 73, 22, 73, 26, 73, 27, 73, 126, 73, 137, 73, 141, 73, 20, 74, 21, 74, 25, 74, 124, 74, 125, 74, 137, 74, 138, 74, 140, 74, 141, 74, 19, 75, 20, 75, 24, 75, 123, 75, 124, 75, 138, 75, 139, 75, 140, 75, 18, 76, 19, 76, 122, 76, 123, 76, 138, 76, 139, 76, 18, 77, 121, 77, 122, 77, 136, 77, 137, 77, 138, 77, 17, 78, 120, 78, 121, 78, 16, 79, 17, 79, 100, 79, 101, 79, 102, 79, 103, 79, 104, 79, 105, 79, 119, 79, 120, 79, 15, 80, 16, 80, 18, 80, 96, 80, 97, 80, 98, 80, 99, 80, 100, 80, 101, 80, 102, 80, 104, 80, 105, 80, 106, 80, 107, 80, 108, 80, 117, 80, 118, 80, 119, 80, 14, 81, 15, 81, 17, 81, 20, 81, 93, 81, 94, 81, 95, 81, 96, 81, 108, 81, 109, 81, 110, 81, 111, 81, 112, 81, 113, 81, 114, 81, 115, 81, 116, 81, 117, 81, 13, 82, 14, 82, 16, 82, 19, 82, 20, 82, 91, 82, 92, 82, 93, 82, 112, 82, 113, 82, 114, 82, 115, 82, 13, 83, 15, 83, 16, 83, 18, 83, 20, 83, 22, 83, 89, 83, 90, 83, 91, 83, 101, 83, 107, 83, 12, 84, 14, 84, 15, 84, 17, 84, 18, 84, 20, 84, 21, 84, 87, 84, 88, 84, 89, 84, 101, 84, 107, 84, 11, 85, 12, 85, 14, 85, 16, 85, 19, 85, 20, 85, 22, 85, 23, 85, 86, 85, 87, 85, 102, 85, 108, 85, 10, 86, 11, 86, 12, 86, 13, 86, 14, 86, 15, 86, 18, 86, 19, 86, 21, 86, 22, 86, 66, 86, 67, 86, 68, 86, 69, 86, 70, 86, 71, 86, 72, 86, 73, 86, 74, 86, 75, 86, 76, 86, 77, 86, 78, 86, 79, 86, 85, 86, 86, 86, 94, 86, 102, 86, 108, 86, 10, 87, 11, 87, 12, 87, 13, 87, 14, 87, 15, 87, 16, 87, 17, 87, 18, 87, 20, 87, 21, 87, 24, 87, 25, 87, 61, 87, 62, 87, 63, 87, 64, 87, 65, 87, 84, 87, 85, 87, 94, 87, 102, 87, 108, 87, 9, 88, 10, 88, 11, 88, 12, 88, 13, 88, 14, 88, 15, 88, 16, 88, 17, 88, 19, 88, 20, 88, 21, 88, 22, 88, 23, 88, 58, 88, 59, 88, 60, 88, 83, 88, 84, 88, 86, 88, 94, 88, 102, 88, 108, 88, 9, 89, 10, 89, 11, 89, 12, 89, 13, 89, 14, 89, 15, 89, 16, 89, 17, 89, 18, 89, 19, 89, 20, 89, 22, 89, 24, 89, 25, 89, 55, 89, 56, 89, 57, 89, 82, 89, 83, 89, 86, 89, 94, 89, 108, 89, 8, 90, 9, 90, 10, 90, 11, 90, 12, 90, 13, 90, 14, 90, 15, 90, 16, 90, 17, 90, 18, 90, 19, 90, 21, 90, 23, 90, 24, 90, 32, 90, 52, 90, 53, 90, 54, 90, 81, 90, 82, 90, 85, 90, 86, 90, 93, 90, 101, 90, 108, 90, 7, 91, 8, 91, 9, 91, 10, 91, 11, 91, 12, 91, 13, 91, 14, 91, 15, 91, 16, 91, 17, 91, 18, 91, 20, 91, 22, 91, 23, 91, 50, 91, 51, 91, 80, 91, 81, 91, 85, 91, 86, 91, 93, 91, 101, 91, 108, 91, 7, 92, 8, 92, 9, 92, 10, 92, 11, 92, 12, 92, 13, 92, 14, 92, 15, 92, 16, 92, 17, 92, 18, 92, 19, 92, 21, 92, 22, 92, 25, 92, 26, 92, 27, 92, 48, 92, 49, 92, 60, 92, 61, 92, 62, 92, 63, 92, 64, 92, 79, 92, 80, 92, 85, 92, 86, 92, 93, 92, 101, 92, 108, 92, 6, 93, 7, 93, 8, 93, 9, 93, 10, 93, 11, 93, 12, 93, 13, 93, 14, 93, 15, 93, 16, 93, 17, 93, 18, 93, 19, 93, 20, 93, 21, 93, 22, 93, 25, 93, 26, 93, 46, 93, 47, 93, 56, 93, 57, 93, 58, 93, 59, 93, 78, 93, 79, 93, 81, 93, 85, 93, 86, 93, 93, 93, 101, 93, 108, 93, 6, 94, 7, 94, 8, 94, 9, 94, 10, 94, 11, 94, 12, 94, 13, 94, 14, 94, 15, 94, 16, 94, 17, 94, 18, 94, 19, 94, 21, 94, 24, 94, 26, 94, 45, 94, 52, 94, 53, 94, 54, 94, 55, 94, 77, 94, 78, 94, 81, 94, 82, 94, 85, 94, 86, 94, 93, 94, 101, 94, 108, 94, 5, 95, 6, 95, 7, 95, 8, 95, 9, 95, 10, 95, 11, 95, 12, 95, 13, 95, 14, 95, 15, 95, 16, 95, 17, 95, 18, 95, 19, 95, 20, 95, 21, 95, 22, 95, 23, 95, 25, 95, 49, 95, 50, 95, 51, 95, 76, 95, 77, 95, 82, 95, 85, 95, 86, 95, 93, 95, 108, 95, 4, 96, 5, 96, 6, 96, 7, 96, 8, 96, 9, 96, 10, 96, 11, 96, 12, 96, 13, 96, 14, 96, 15, 96, 16, 96, 17, 96, 18, 96, 19, 96, 20, 96, 21, 96, 23, 96, 24, 96, 47, 96, 48, 96, 75, 96, 76, 96, 82, 96, 83, 96, 85, 96, 86, 96, 93, 96, 101, 96, 108, 96, 4, 97, 5, 97, 6, 97, 7, 97, 8, 97, 9, 97, 10, 97, 11, 97, 12, 97, 13, 97, 14, 97, 15, 97, 16, 97, 17, 97, 18, 97, 19, 97, 20, 97, 21, 97, 22, 97, 24, 97, 26, 97, 46, 97, 74, 97, 75, 97, 83, 97, 84, 97, 86, 97, 93, 97, 98, 97, 99, 97, 101, 97, 102, 97, 107, 97, 3, 98, 4, 98, 5, 98, 6, 98, 7, 98, 8, 98, 9, 98, 10, 98, 11, 98, 12, 98, 13, 98, 14, 98, 15, 98, 16, 98, 17, 98, 18, 98, 19, 98, 20, 98, 21, 98, 22, 98, 23, 98, 25, 98, 38, 98, 45, 98, 46, 98, 47, 98, 48, 98, 49, 98, 50, 98, 51, 98, 52, 98, 53, 98, 54, 98, 55, 98, 56, 98, 57, 98, 58, 98, 59, 98, 60, 98, 61, 98, 62, 98, 63, 98, 73, 98, 85, 98, 86, 98, 87, 98, 93, 98, 94, 98, 96, 98, 97, 98, 98, 98, 103, 98, 104, 98, 105, 98, 106, 98, 3, 99, 4, 99, 5, 99, 6, 99, 7, 99, 8, 99, 9, 99, 10, 99, 11, 99, 12, 99, 13, 99, 14, 99, 15, 99, 16, 99, 17, 99, 18, 99, 19, 99, 20, 99, 21, 99, 22, 99, 23, 99, 24, 99, 25, 99, 64, 99, 65, 99, 66, 99, 72, 99, 87, 99, 91, 99, 92, 99, 93, 99, 95, 99, 96, 99, 97, 99, 98, 99, 105, 99, 106, 99, 3, 100, 4, 100, 5, 100, 6, 100, 7, 100, 8, 100, 9, 100, 10, 100, 11, 100, 12, 100, 13, 100, 14, 100, 15, 100, 16, 100, 17, 100, 18, 100, 19, 100, 20, 100, 21, 100, 22, 100, 23, 100, 24, 100, 25, 100, 34, 100, 44, 100, 69, 100, 70, 100, 71, 100, 87, 100, 88, 100, 89, 100, 90, 100, 91, 100, 97, 100, 98, 100, 107, 100, 2, 101, 3, 101, 4, 101, 5, 101, 6, 101, 7, 101, 8, 101, 9, 101, 10, 101, 11, 101, 12, 101, 13, 101, 14, 101, 15, 101, 16, 101, 17, 101, 18, 101, 19, 101, 20, 101, 21, 101, 22, 101, 23, 101, 24, 101, 69, 101, 70, 101, 89, 101, 90, 101, 91, 101, 2, 102, 3, 102, 4, 102, 5, 102, 6, 102, 7, 102, 8, 102, 9, 102, 10, 102, 11, 102, 12, 102, 13, 102, 14, 102, 15, 102, 16, 102, 17, 102, 18, 102, 19, 102, 20, 102, 21, 102, 22, 102, 23, 102, 24, 102, 47, 102, 48, 102, 49, 102, 50, 102, 51, 102, 52, 102, 53, 102, 54, 102, 55, 102, 56, 102, 57, 102, 58, 102, 59, 102, 67, 102, 68, 102, 69, 102, 90, 102, 91, 102, 2, 103, 3, 103, 4, 103, 5, 103, 6, 103, 7, 103, 8, 103, 9, 103, 10, 103, 11, 103, 12, 103, 13, 103, 14, 103, 15, 103, 16, 103, 17, 103, 18, 103, 19, 103, 20, 103, 21, 103, 22, 103, 23, 103, 24, 103, 38, 103, 60, 103, 61, 103, 62, 103, 63, 103, 64, 103, 66, 103, 67, 103, 3, 104, 4, 104, 5, 104, 6, 104, 7, 104, 8, 104, 9, 104, 10, 104, 11, 104, 12, 104, 13, 104, 14, 104, 15, 104, 16, 104, 17, 104, 18, 104, 19, 104, 20, 104, 21, 104, 22, 104, 23, 104, 24, 104, 44, 104, 45, 104, 46, 104, 47, 104, 64, 104, 65, 104, 66, 104, 67, 104, 68, 104, 5, 105, 6, 105, 7, 105, 8, 105, 9, 105, 10, 105, 11, 105, 12, 105, 13, 105, 14, 105, 15, 105, 16, 105, 17, 105, 18, 105, 19, 105, 20, 105, 21, 105, 22, 105, 23, 105, 24, 105, 48, 105, 49, 105, 50, 105, 51, 105, 62, 105, 63, 105, 64, 105, 69, 105, 70, 105, 71, 105, 72, 105, 7, 106, 8, 106, 9, 106, 10, 106, 11, 106, 12, 106, 13, 106, 14, 106, 15, 106, 16, 106, 17, 106, 18, 106, 19, 106, 20, 106, 21, 106, 22, 106, 23, 106, 30, 106, 31, 106, 52, 106, 53, 106, 54, 106, 60, 106, 61, 106, 62, 106, 73, 106, 74, 106, 9, 107, 10, 107, 11, 107, 12, 107, 13, 107, 14, 107, 15, 107, 16, 107, 17, 107, 18, 107, 19, 107, 20, 107, 21, 107, 22, 107, 23, 107, 32, 107, 33, 107, 39, 107, 40, 107, 41, 107, 55, 107, 56, 107, 58, 107, 59, 107, 60, 107, 11, 108, 12, 108, 13, 108, 14, 108, 15, 108, 16, 108, 17, 108, 18, 108, 19, 108, 20, 108, 21, 108, 22, 108, 34, 108, 35, 108, 42, 108, 43, 108, 44, 108, 45, 108, 57, 108, 58, 108, 59, 108, 16, 109, 17, 109, 18, 109, 19, 109, 20, 109, 21, 109, 36, 109, 37, 109, 46, 109, 47, 109, 48, 109, 55, 109, 56, 109, 60, 109, 61, 109, 19, 110, 20, 110, 21, 110, 22, 110, 23, 110, 24, 110, 25, 110, 26, 110, 27, 110, 38, 110, 39, 110, 49, 110, 50, 110, 51, 110, 52, 110, 53, 110, 54, 110, 62, 110, 23, 111, 24, 111, 25, 111, 26, 111, 27, 111, 28, 111, 29, 111, 30, 111, 31, 111, 32, 111, 33, 111, 34, 111, 40, 111, 41, 111, 47, 111, 48, 111, 49, 111, 50, 111, 51, 111, 53, 111, 54, 111, 55, 111, 56, 111, 33, 112, 34, 112, 35, 112, 36, 112, 37, 112, 38, 112, 39, 112, 40, 112, 41, 112, 42, 112, 43, 112, 44, 112, 45, 112, 46, 112, 47, 112, 57, 112, 58, 112, 38, 113, 39, 113, 40, 113, 41, 113, 42, 113, 44, 113, 45, 113, 59, 113, 46, 114, 47, 115, 48, 115, 49, 116, 50, 117, 51, 117, 52, 118, };

  int i;
  int pixel_size = sizeof(pixelArray)/sizeof(pixelArray[0]);
  unsigned colour = 0b111;

  for(i = 0; i < pixel_size; i += 2) {
    vga_plot(pixelArray[i], pixelArray[i+1], colour);
  }
}
